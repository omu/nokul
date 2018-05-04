# frozen_string_literal: true

require 'test_helper'

class UnitCalendarEventTest < ActiveSupport::TestCase
  test 'should not save without start_date' do
    unit_calendar_events(:one).start_date = nil
    assert_not unit_calendar_events(:one).valid?
  end

  test 'should be belongs to calendar_title' do
    assert unit_calendar_events(:one).calendar_title
  end

  test 'should be belongs to unit' do
    assert unit_calendar_events(:one).unit
  end

  test 'should be belongs to academic calendar' do
    assert unit_calendar_events(:one).academic_calendar
  end

  test 'unit event should be unique' do
    dup_unit_event = unit_calendar_events(:one).dup
    assert_not dup_unit_event.valid?
  end
end
