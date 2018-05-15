# frozen_string_literal: true

require 'test_helper'

class CalendarTypeTest < ActiveSupport::TestCase
  # presence validation tests
  test 'should not save calendar_type without name' do
    calendar_types(:one).name = nil
    assert_not calendar_types(:one).valid?
  end

  # relational tests
  test 'should contain titles' do
    assert calendar_types(:one).titles
  end

  # duplication tests
  test 'name should be unique' do
    assert_not calendar_types(:one).dup.valid?
  end
end
