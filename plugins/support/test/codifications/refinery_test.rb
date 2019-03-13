# frozen_string_literal: true

require 'test_helper'

module Nokul
  module Support
    using Codifications::Refinery

    class CodificationsRefineryTest < ActiveSupport::TestCase
      test 'to_number refinement' do
        assert_equal 1, '01'.to_number(10)
        assert_equal 10, '0A'.to_number(16)
        assert_equal 35, '0Z'.to_number(36)
      end

      test 'to_string refinement' do
        assert_equal '0001', 1.to_string(10, 4)
        assert_equal '000A', 10.to_string(16, 4)
        assert_equal '000Z', 35.to_string(36, 4)
      end
    end
  end
end
