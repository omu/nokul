# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Tenant
    module Codification
      class UnitTest < ActiveSupport::TestCase
        test 'code_generator works' do
          coder = Unit.code_generator(starting: '0023', ending: '0025', memory: nil)
          assert_equal '0023', coder.run
          assert_equal '0024', coder.run
          assert_equal '0025', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'code_generator works as hexadecimal sequences automagically' do
          coder = Unit.code_generator(starting: 'A009', ending: 'A00C', memory: nil)
          assert_equal 'A009', coder.run
          assert_equal 'A00A', coder.run
          assert_equal 'A00B', coder.run
          assert_equal 'A00C', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'code_generator works as alphabetical sequences automagically' do
          coder = Unit.code_generator(starting: '3009', ending: '300H', memory: nil)
          assert_equal '3009', coder.run
          assert_equal '300A', coder.run
          assert_equal '300B', coder.run
          assert_equal '300C', coder.run
          assert_equal '300D', coder.run
          assert_equal '300E', coder.run
          assert_equal '300F', coder.run
          assert_equal '300G', coder.run
          assert_equal '300H', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'code_generator works with patterns' do
          coder = Unit.code_generator(starting: '8001', ending: '8009', only: '^[^3-7]+$', memory: nil)
          assert_equal '8001', coder.run
          assert_equal '8002', coder.run
          assert_equal '8008', coder.run
          assert_equal '8009', coder.run

          assert_raise(StopIteration) { coder.run }
        end
      end
    end
  end
end
