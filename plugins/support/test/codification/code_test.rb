# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class CodeTest < ActiveSupport::TestCase
        test 'concrete code class should implement required methods' do
          %i[
            take_in
            take_out
          ].each do |method|
            assert_raise(NotImplementedError) { Class.new(Code).new([]).send method }
          end
        end

        module TestSimpleCode
          class SimpleCode < Code
            protected

            def take_in(value)
              value.must_be_any_of! [String]
            end

            def take_out(value)
              value
            end
          end
        end

        test 'subclassing should work' do
          code = TestSimpleCode::SimpleCode.new %w[foo bar baz]

          assert_equal 'foo', code.next
          assert_equal 'bar', code.next
          assert_equal 'baz', code.peek
          assert_equal 'baz', code.next

          assert_raise(StopIteration) { code.peek }
          assert_raise(StopIteration) { code.next }

          code.rewind
          assert_equal 'foo', code.next
        end

        test 'should behave well at the edge cases' do
          code = TestSimpleCode::SimpleCode.new []
          assert_raise(StopIteration) { code.peek }
        end
      end
    end
  end
end
