# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    module  Codification
      class RandomNumericCodesTest < ActiveSupport::TestCase
        test 'simple use case works' do
          coder = Codification.random_numeric_codes('5'..'9')
          assert_match(/^[5-9]$/, coder.run)
          assert_match(/^[5-9]$/, coder.run)
          assert_match(/^[5-9]$/, coder.run)
          assert_match(/^[5-9]$/, coder.run)
          assert_match(/^[5-9]$/, coder.run)

          assert_raise(StopIteration) { coder.run }
        end

        test 'API with singular name works' do
          assert_match(/^[5-9]$/, Codification.random_numeric_code('5'..'9'))
        end

        test 'memory works' do
          memory = SimpleMemory.new

          coder = Codification.random_numeric_codes '0'..'9', memory: memory
          5.times { coder.run }

          other = Codification.random_numeric_codes '0'..'9', memory: memory
          5.times { other.run }

          assert_raise(StopIteration) { coder.run }
          assert_raise(StopIteration) { other.run }
        end

        test 'prefix and length options work' do
          coder = Codification.random_numeric_codes '0'..'999', prefix: 'xyz-', net_length: 12
          assert_match(/^xyz-\d{12}$/, coder.run)
        end

        test 'regex post process option works' do
          coder = Codification.random_numeric_codes '0'..'999', post_process: /^1+$/
          assert_equal '111', coder.run
          assert_raise(StopIteration, Error) { coder.run }
        end

        test 'proc post process option works' do
          coder = Codification.random_numeric_codes '0'..'999', post_process: proc { |string| "#{string}.a" }
          assert_match(/\d{3}[.]a/, coder.run)
        end

        test 'can produce available numbers' do
          coder = Codification.random_numeric_codes('777'..'779')
          assert_equal %w[777 778 779], coder.available!(3).sort
        end
      end
    end
  end
end
