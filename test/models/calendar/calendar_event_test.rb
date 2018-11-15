# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  setup do
    @calendar_event = calendar_events(:one)
  end

  # relations
  %i[
    academic_calendar
    calendar_title
    term
  ].each do |property|
    test "a calendar event can communicate with #{property}" do
      assert @calendar_event.send(property)
    end
  end

  # validations: presence
  test 'should not save without start_date' do
    @calendar_event.start_date = nil
    assert_not @calendar_event.valid?
    assert_not_empty @calendar_event.errors[:start_date]
  end

  # validations: uniqueness
  test 'event should be unique' do
    fake_event = @calendar_event.dup
    assert_not fake_event.valid?
    assert_not_empty fake_event.errors[:academic_calendar]
  end

  # scopes
  test 'active scope returns active calendar events' do
    assert_includes CalendarEvent.active, @calendar_event
    assert_not_includes CalendarEvent.active, calendar_events(:twenty)
  end
end
