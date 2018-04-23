# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # enum tests
  test 'Unit statuses match with YOKSIS values' do
    assert_equal Unit.statuses['passive'], 0
    assert_equal Unit.statuses['active'], 1
    assert_equal Unit.statuses['partially_passive'], 2
    assert_equal Unit.statuses['closed'], 3
    assert_equal Unit.statuses['archived'], 4
    assert_equal Unit.statuses['unknown'], 5
  end

  test 'Unit instruction types match with YOKSIS values' do
    assert_equal Unit.instruction_types['formal'], 1
    assert_equal Unit.instruction_types['evening'], 2
    assert_equal Unit.instruction_types['distance_education'], 3
    assert_equal Unit.instruction_types['open_education'], 4
  end
end
