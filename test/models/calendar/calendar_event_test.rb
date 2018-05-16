# frozen_string_literal: true

require 'test_helper'

class CalendarEventTest < ActiveSupport::TestCase
  # presence validation tests
  test 'should not save without start_date' do
    calendar_events(:one).start_date = nil
    refute calendar_events(:one).valid?
  end

  # relational tests
  %i[
    academic_calendar
    calendar_title
  ].each do |property|
    test "a calendar event can communicate with #{property}" do
      assert calendar_events(:one).send(property)
    end
  end

  # duplication tests
  test 'event should be unique' do
    refute calendar_events(:one).dup.valid?
  end
end
