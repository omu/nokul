# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Tenant
    module Codification
      class UnitTest < ActiveSupport::TestCase
        test 'code_generator works' do
          coder = Unit.code_generator(starting: '023', ending: '025', memory: nil)
          assert_equal '023', coder.run
          assert_equal '024', coder.run
          assert_equal '025', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'code_generator works as hexadecimal sequences automagically' do
          coder = Unit.code_generator(starting: '009', ending: '00C', memory: nil)
          assert_equal '009', coder.run
          assert_equal '00A', coder.run
          assert_equal '00B', coder.run
          assert_equal '00C', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'code_generator works as alphabetical sequences automagically' do
          coder = Unit.code_generator(starting: '009', ending: '00H', memory: nil)
          assert_equal '009', coder.run
          assert_equal '00A', coder.run
          assert_equal '00B', coder.run
          assert_equal '00C', coder.run
          assert_equal '00D', coder.run
          assert_equal '00E', coder.run
          assert_equal '00F', coder.run
          assert_equal '00G', coder.run
          assert_equal '00H', coder.run

          assert_raise(StopIteration) { coder.run }
        end

        test 'code_generator works with patterns' do
          coder = Unit.code_generator(starting: '001', ending: '009', pattern: '^[^3-7]+$', memory: nil)
          assert_equal '001', coder.run
          assert_equal '002', coder.run
          assert_equal '008', coder.run
          assert_equal '009', coder.run

          assert_raise(StopIteration) { coder.run }
        end
      end
    end
  end
end
