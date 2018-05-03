# frozen_string_literal: true

require 'test_helper'

class CalendarTypeTest < ActiveSupport::TestCase
  test 'should not save calendar_type without name' do
    assert_not CalendarType.new.save
  end

  test 'name should be unique' do
    dup_calendar_type = calendar_types(:one).dup
    assert_not dup_calendar_type.valid?
  end

  test 'should contain titles' do
    assert calendar_types(:one).titles
  end
end
