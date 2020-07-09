# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class ProcessorTest < ActiveSupport::TestCase
        test 'regexps work' do
          assert_raise(Skip) { Processor.new(post_process: /^[0-3]+/).process(Object.new, '456') }
        end

        test 'procs work' do
          assert_equal 'FOO', Processor.new(post_process: proc { |s| s.upcase }).process(Object.new, 'foo')
        end

        module TestDummy
          class Dummy
            attr_reader :options

            def initialize(**options)
              @options = options.dup
            end
          end
        end

        test 'builtins work' do
          processor = Processor.new post_process: %i[non_offensive? non_reserved? random_suffix]
          assert_match(/^foo.\d{3}$/, processor.process(TestDummy::Dummy.new, 'foo'))
          assert_raise(Skip) { processor.process(TestDummy::Dummy.new, 'salak') }
          assert_raise(Skip) { processor.process(TestDummy::Dummy.new, 'if') }
        end

        test 'should accept a builtin_post_process option' do
          processor = Processor.new builtin_post_process: :non_offensive?, post_process: %i[non_reserved? random_suffix]
          assert_match(/^foo.\d+$/, processor.process(Object.new, 'foo'))
          assert_raise(Skip) { processor.process(Object.new, 'salak') }
          assert_raise(Skip) { processor.process(Object.new, 'if') }
        end

        test 'custom builtins should work' do
          class Codification::Processor # rubocop:disable Style/ClassAndModuleChildren
            define :xxx do |string|
              string + 'xxx'
            end
          end

          assert_equal 'fooxxx', Processor.new(post_process: :xxx).process(Object.new, 'foo')
        end

        test 'custom builtins ending with a question mark should work as a predicator' do
          class Codification::Processor # rubocop:disable Style/ClassAndModuleChildren
            define :xxx? do |string|
              string == 'xxx'
            end
          end

          assert_raise(Skip) { Processor.new(post_process: :xxx?).process(Object.new, 'foo') }
        end

        module TestTwo
          class Dummy
            def internal
              'bar'
            end
          end
        end

        test 'processes should be able to access instance' do
          assert_equal 'barfoo', Processor.new(post_process: proc { |s| internal + s }).process(TestTwo::Dummy.new,
                                                                                                'foo')
        end
      end
    end
  end
end
