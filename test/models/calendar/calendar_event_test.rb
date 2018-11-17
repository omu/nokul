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
    calendar_type
    academic_term
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

  # callbacks
  test 'callback must set calendar_type_id and academic_term_id' do
    calendar_event = calendar_events(:twenty)
    calendar_event.calendar_title = calendar_titles(:two)
    calendar = calendar_event.academic_calendar
    event = CalendarEvent.create(
      academic_calendar: academic_calendars(:lisans_calendar_spring_2017_2018),
      calendar_title: calendar_titles(:two),
      start_date: '2018-01-25 08:00:00'
    )
    assert_equal event.calendar_type, calendar.calendar_type
    assert_equal event.academic_term, calendar.academic_term
  end

  # scopes
  test 'active scope returns active calendar events' do
    assert_includes CalendarEvent.active, @calendar_event
    assert_not_includes CalendarEvent.active, calendar_events(:twenty)
  end
end
