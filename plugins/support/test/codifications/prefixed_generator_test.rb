# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    class CodificationsPrefixedGeneratorTest < ActiveSupport::TestCase
      test 'basic use case should just work' do
        generator = Codifications::PrefixedGenerator.new '123', prefix: %w[203 19]
        number = generator.generate
        assert_equal Codifications::PrefixedGenerator.length, number.length
        assert_equal '20319123', number
        assert_equal '124', generator.next_sequence
        assert_equal '001', generator.initial_sequence
      end

      test 'getting next sequence should not affect generator seed' do
        generator = Codifications::PrefixedGenerator.new '123', prefix: %w[203 19]
        assert_equal '20319123', generator.generate
        assert_equal '20319124', generator.generate
        assert_equal '125', generator.next_sequence
        assert_equal '20319125', generator.generate
      end

      test 'getting first sequence should not affect generator seed' do
        generator = Codifications::PrefixedGenerator.new '123', prefix: %w[203 19]
        assert_equal '001', generator.initial_sequence
        assert_equal '20319123', generator.generate
      end

      test 'giving a nil starting sequence should reset generator' do
        generator = Codifications::PrefixedGenerator.new nil, prefix: %w[203 19]
        assert_equal '20319001', generator.generate
        assert_equal '20319002', generator.generate
        assert_equal '003', generator.next_sequence
      end

      test 'giving a blank starting sequence should also reset generator' do
        generator = Codifications::PrefixedGenerator.new '', prefix: %w[203 19]
        assert_equal '20319001', generator.generate
        assert_equal '20319002', generator.generate
        assert_equal '003', generator.next_sequence
      end

      test 'lack of a trailing prefix should produce long sequences' do
        generator = Codifications::PrefixedGenerator.new '00123', prefix: '203'
        assert_equal '00001', generator.initial_sequence
        assert_equal '20300123', generator.generate
        assert_equal '00124', generator.next_sequence
      end

      test 'can pass extra options to the decorated generator' do
        generator = Codifications::PrefixedGenerator.new nil, prefix: '203', deny: /0/
        assert_equal '00001', generator.initial_sequence
        assert_equal '20311111', generator.generate
        assert_equal '11112', generator.next_sequence
      end

      class FlatGenerator < Codifications::PrefixedGenerator
        self.length = 12

        delegate :generate, to: :generator

        def initial_sequence
          '0' * (length - 1) + '1'
        end
      end

      test 'custom generators should work' do
        generator = FlatGenerator.new nil
        assert_equal '000000000001', generator.initial_sequence
        assert_equal '000000000001', generator.generate
        assert_equal '000000000002', generator.generate
        assert_equal '000000000003', generator.next_sequence
      end

      test 'too long starting sequences should raise exception' do
        exception = assert_raise(Codifications::PrefixedGenerator::Error) do
          Codifications::PrefixedGenerator.new '1234567', prefix: %w[203 19]
        end
        assert_equal 'Incorrect length for starting sequence: 1234567', exception.message
      end

      test 'too short starting sequences should raise exception' do
        exception = assert_raise(Codifications::PrefixedGenerator::Error) do
          Codifications::PrefixedGenerator.new '123', prefix: '203'
        end
        assert_equal 'Incorrect length for starting sequence: 123', exception.message
      end

      class TooShortGenerator < Codifications::PrefixedGenerator
        self.length = 2
      end

      test 'generator length can not set too short' do
        exception = assert_raise(Codifications::PrefixedGenerator::Error) do
          TooShortGenerator.new '123', prefix: %w[203 19]
        end
        assert_equal 'Generator length is too short: 2', exception.message
      end

      test 'too long prefixes should raise exception' do
        exception = assert_raise(Codifications::PrefixedGenerator::Error) do
          Codifications::PrefixedGenerator.new '123', prefix: %w[12345 19]
        end
        assert_equal 'Effective sequence length is too short', exception.message
      end
    end
  end
end
