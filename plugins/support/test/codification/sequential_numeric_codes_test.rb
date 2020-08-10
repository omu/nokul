# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class SequentialNumericCodesTest < ActiveSupport::TestCase
        test 'simple use case works with starting string' do
          coder = Codification.sequential_numeric_codes '0001'
          assert_equal '0001', coder.run
          assert_equal '0002', coder.run

          coder = Codification.sequential_numeric_codes '9998'
          assert_equal '9998', coder.run
          assert_equal '9999', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'simple use case works with ranges' do
          coder = Codification.sequential_numeric_codes '0001'..'0003'
          assert_equal '0001', coder.run
          assert_equal '0002', coder.run
          assert_equal '0003', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'API with singular name works' do
          assert_equal '0001', Codification.sequential_numeric_code('0001')
        end

        test 'simple use case with memory works' do
          memory = SimpleMemory.new

          coder = Codification.sequential_numeric_codes '0001', memory: memory
          assert_equal '0001', coder.run
          assert_equal '0002', coder.run

          other = Codification.sequential_numeric_codes '0001', memory: memory
          assert_equal '0003', other.run
          assert_equal '0004', other.run

          assert_equal '0005', coder.run
        end

        test 'prefix option works' do
          coder = Codification.sequential_numeric_codes '0001', prefix: 'xyz-'
          assert_equal 'xyz-0001', coder.run
          assert_equal 'xyz-0002', coder.run
        end

        test 'net_length option works' do
          coder = Codification.sequential_numeric_codes '0001', prefix: 'xyz-', net_length: 12
          assert_equal 'xyz-000000000001', coder.run
          assert_equal 'xyz-000000000002', coder.run
        end

        test 'regex post process option works' do
          coder = Codification.sequential_numeric_codes '0001', post_process: /[^2]$/
          assert_equal '0001', coder.run
          assert_equal '0003', coder.run
        end

        test 'proc post process option works' do
          coder = Codification.sequential_numeric_codes '0001', post_process: proc { |string| "#{string}.a" }
          assert_equal '0001.a', coder.run
          assert_equal '0002.a', coder.run
        end

        test 'builtin post process works' do
          coder = Codification.sequential_numeric_codes '0001', post_process: :random_suffix
          assert_match(/0001[.]\d+/, coder.run)
        end

        test 'can produce available numbers' do
          coder = Codification.sequential_numeric_codes '0002'..'9999'
          assert_equal %w[0002 0003 0004], coder.available!(3)
        end
      end
    end
  end
end
