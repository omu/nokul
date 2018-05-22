# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  # relations
  %i[
    academic_calendar
    calendar_title
  ].each do |property|
    test "a calendar event can communicate with #{property}" do
      assert calendar_events(:one).send(property)
    end
  end

  # validations: presence
  test 'should not save without start_date' do
    calendar_events(:one).start_date = nil
    assert_not calendar_events(:one).valid?
    assert_not_empty calendar_events(:one).errors[:start_date]
  end

  # validations: uniqueness
  test 'event should be unique' do
    fake_event = calendar_events(:one).dup
    assert_not fake_event.valid?
    assert_not_empty fake_event.errors[:academic_calendar]
  end
end
