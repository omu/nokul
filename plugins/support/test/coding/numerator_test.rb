# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    class CodingNumeratorTest < ActiveSupport::TestCase
      test 'basic use case should just work' do
        numerator = Coding::PrefixedNumerator.new '123', prefix: '20319'
        number = numerator.number
        assert_equal Coding::PrefixedNumerator.length, number.length
        assert_equal '20319123', number
        assert_equal '124', numerator.next_sequence
        assert_equal '001', numerator.first_sequence
      end

      test 'getting next sequence should not affect numerator seed' do
        numerator = Coding::PrefixedNumerator.new '123', prefix: '20319'
        assert_equal '20319123', numerator.number
        assert_equal '20319124', numerator.number
        assert_equal '125', numerator.next_sequence
        assert_equal '20319125', numerator.number
      end

      test 'getting first sequence should not affect numerator seed' do
        numerator = Coding::PrefixedNumerator.new '123', prefix: %w[203 19]
        assert_equal '001', numerator.first_sequence
        assert_equal '20319123', numerator.number
      end

      test 'giving a nil starting sequence should work' do
        numerator = Coding::PrefixedNumerator.new nil, prefix: %w[203 19]
        assert_equal '20319001', numerator.number
        assert_equal '20319002', numerator.number
        assert_equal '003', numerator.next_sequence
      end

      test 'lack of a trailing prefix should produce long sequences' do
        numerator = Coding::PrefixedNumerator.new '00123', prefix: '203'
        assert_equal '00001', numerator.first_sequence
        assert_equal '20300123', numerator.number
        assert_equal '00124', numerator.next_sequence
      end

      class FlatNumerator < Coding::AbstractNumerator
        self.length = 12

        def number
          generator.generate
        end

        def first_sequence
          '0' * (length - 1) + '1'
        end
      end

      test 'custom numerators should work' do
        numerator = FlatNumerator.new nil
        assert_equal '000000000001', numerator.first_sequence
        assert_equal '000000000001', numerator.number
        assert_equal '000000000002', numerator.number
        assert_equal '000000000003', numerator.next_sequence
      end

      test 'too long starting sequences should raise exception' do
        exception = assert_raise(Coding::NumeratorError) do
          Coding::PrefixedNumerator.new '1234567', prefix: '20319'
        end
        assert_equal 'Incorrect length for starting sequence: 1234567', exception.message
      end

      test 'too short starting sequences should raise exception' do
        exception = assert_raise(Coding::NumeratorError) do
          Coding::PrefixedNumerator.new '123', prefix: '203'
        end
        assert_equal 'Incorrect length for starting sequence: 123', exception.message
      end

      class CustomNumerator < Coding::PrefixedNumerator
        self.length = 2
      end

      test 'numerator length can not set too short' do
        exception = assert_raise(Coding::NumeratorError) do
          CustomNumerator.new '123', prefix: '20319'
        end
        assert_equal 'Numerator length is too short: 2', exception.message
      end

      test 'too long prefixes should raise exception' do
        exception = assert_raise(Coding::NumeratorError) do
          Coding::PrefixedNumerator.new '123', prefix: %w[12345 19]
        end
        assert_equal 'Effective sequence length is too short', exception.message
      end
    end
  end
end
