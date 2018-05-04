# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  test 'should not save without start_date' do
    calendar_events(:one).start_date = nil
    assert_not calendar_events(:one).valid?
  end

  test 'should belongs to academic_calendar' do
    assert calendar_events(:one).academic_calendar
  end

  test 'should belongs to calendar_title' do
    assert calendar_events(:one).calendar_title
  end

  test 'event should be unique' do
    dup_event = calendar_events(:one).dup
    assert_not dup_event.valid?
  end
end
