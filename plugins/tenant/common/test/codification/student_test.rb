# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Tenant
    module Codification
      class StudentTest < ActiveSupport::TestCase
        test 'short_number_generator works' do
          coder = Student.short_number_generator(unit_code: '3456', year: '19', starting: '0023')
          assert_equal '3456190023', coder.run
          assert_equal '3456190024', coder.run
        end

        test 'short_number_generator unit_code sanitization works' do
          assert_raise(ArgumentError) do
            Student.short_number_generator(unit_code: '20', year: '19', starting: '0023')
          end
        end

        test 'short_number_generator year sanitization works' do
          assert_raise(ArgumentError) do
            Student.short_number_generator(unit_code: '3456', year: '2019', starting: '0023')
          end
        end

        test 'short_number_generator starting sanitization works' do
          assert_raise(ArgumentError) do
            Student.short_number_generator(unit_code: '3456', year: '19', starting: '23')
          end
        end

        test 'short_number_generator can handle a blank or zero starting' do
          coder = Student.short_number_generator(unit_code: '3456', year: '19', starting: nil)
          assert_equal '3456190001', coder.run

          coder = Student.short_number_generator(unit_code: '3456', year: '19', starting: '0000')
          assert_equal '3456190001', coder.run
        end

        test 'long_number_generator works' do
          coder = Student.long_number_generator(unit_code: '3456', starting: '123456')
          assert_equal '3456123456', coder.run
          assert_equal '3456123457', coder.run
        end

        test 'long_number_generator starting sanitization works' do
          assert_raise(ArgumentError) do
            Student.long_number_generator(unit_code: '3456', starting: '023')
          end
        end
      end
    end
  end
end
