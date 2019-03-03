# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    class CodificationsPrefixedCoderTest < ActiveSupport::TestCase
      test 'basic use case should just work' do
        coder = Codifications::PrefixedCoder.new '123', prefix: %w[203 19]
        number = coder.run
        assert_equal Codifications::PrefixedCoder.length, number.length
        assert_equal '20319123', number
        assert_equal '124', coder.next_sequence
        assert_equal '001', coder.initial_sequence
      end

      test 'getting next sequence should not affect coder seed' do
        coder = Codifications::PrefixedCoder.new '123', prefix: %w[203 19]
        assert_equal '20319123', coder.run
        assert_equal '20319124', coder.run
        assert_equal '125', coder.next_sequence
        assert_equal '20319125', coder.run
      end

      test 'getting first sequence should not affect coder seed' do
        coder = Codifications::PrefixedCoder.new '123', prefix: %w[203 19]
        assert_equal '001', coder.initial_sequence
        assert_equal '20319123', coder.run
      end

      test 'giving a nil starting sequence should reset coder' do
        coder = Codifications::PrefixedCoder.new nil, prefix: %w[203 19]
        assert_equal '20319001', coder.run
        assert_equal '20319002', coder.run
        assert_equal '003', coder.next_sequence
      end

      test 'giving a blank starting sequence should also reset coder' do
        coder = Codifications::PrefixedCoder.new '', prefix: %w[203 19]
        assert_equal '20319001', coder.run
        assert_equal '20319002', coder.run
        assert_equal '003', coder.next_sequence
      end

      test 'lack of a trailing prefix should run long sequences' do
        coder = Codifications::PrefixedCoder.new '00123', prefix: '203'
        assert_equal '00001', coder.initial_sequence
        assert_equal '20300123', coder.run
        assert_equal '00124', coder.next_sequence
      end

      test 'can pass extra options to the decorated coder' do
        coder = Codifications::PrefixedCoder.new nil, prefix: '203', deny: /0/
        assert_equal '00001', coder.initial_sequence
        assert_equal '20311111', coder.run
        assert_equal '11112', coder.next_sequence
      end

      class FlatCoder < Codifications::PrefixedCoder
        self.length = 12

        delegate :run, to: :coder

        def initial_sequence
          '0' * (length - 1) + '1'
        end
      end

      test 'custom coders should work' do
        coder = FlatCoder.new nil
        assert_equal '000000000001', coder.initial_sequence
        assert_equal '000000000001', coder.run
        assert_equal '000000000002', coder.run
        assert_equal '000000000003', coder.next_sequence
      end

      test 'too long starting sequences should raise exception' do
        exception = assert_raise(Codifications::PrefixedCoder::Error) do
          Codifications::PrefixedCoder.new '1234567', prefix: %w[203 19]
        end
        assert_equal 'Incorrect length for starting sequence: 1234567', exception.message
      end

      test 'too short starting sequences should raise exception' do
        exception = assert_raise(Codifications::PrefixedCoder::Error) do
          Codifications::PrefixedCoder.new '123', prefix: '203'
        end
        assert_equal 'Incorrect length for starting sequence: 123', exception.message
      end

      class TooShortCoder < Codifications::PrefixedCoder
        self.length = 2
      end

      test 'coder length can not set too short' do
        exception = assert_raise(Codifications::PrefixedCoder::Error) do
          TooShortCoder.new '123', prefix: %w[203 19]
        end
        assert_equal 'Coder length is too short: 2', exception.message
      end

      test 'too long prefixes should raise exception' do
        exception = assert_raise(Codifications::PrefixedCoder::Error) do
          Codifications::PrefixedCoder.new '123', prefix: %w[12345 19]
        end
        assert_equal 'Effective sequence length is too short', exception.message
      end
    end
  end
end
