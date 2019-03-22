# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class CoderTest < ActiveSupport::TestCase
        test 'default options should be duplicated' do
          class Foo < Coder
            setup foo: 13
          end

          class Bar < Foo
            setup foo: 19, bar: 23
          end

          assert_equal 13, Foo.default_options[:foo]
          assert_nil       Foo.default_options[:bar]
          assert_equal 19, Bar.default_options[:foo]
          assert_equal 23, Bar.default_options[:bar]
        end

        test 'only codes should be accepted' do
          assert_raise(TypeError) { Coder.new 13 }
        end

        test 'loop guard works' do
          class Bogus < Code
            def emit
              %w[same]
            end

            def convert(source)
              source
            end
          end

          coder = Coder.new Bogus.new(0..Float::INFINITY)

          coder.run
          err = assert_raise(Error) { coder.run }
          assert err.message.include? 'many tries'
        end

        test 'dry run should work' do
          coder = Codification.sequential_numeric_codes '0013'..'9999'
          assert_equal '0013', coder.run
          assert_equal '0014', coder.dry
          assert_equal '0014', coder.run
        end
      end
    end
  end
end
