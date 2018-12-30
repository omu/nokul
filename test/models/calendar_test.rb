# frozen_string_literal: true

require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  setup do
    @calendar = calendars(:uzem_calendar)
  end

  # relations
  %i[
    academic_term
    calendar_events
    calendar_event_types
    unit_calendars
    units
  ].each do |property|
    test "calendar can communicate with #{property}" do
      assert @calendar.send(property)
    end
  end

  # validations: presence
  %i[
    name
    timezone
    senate_decision_no
  ].each do |property|
    test "presence validations for #{property} of a calendar" do
      @calendar.send("#{property}=", nil)
      assert_not @calendar.valid?
      assert_not_empty @calendar.errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
  ].each do |property|
    test "uniqueness validations for #{property} of a calendar" do
      fake = @calendar.dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # other validations
  %i[
    name
    timezone
    senate_decision_no
  ].each do |property|
    test "#{property} of calendar can not be longer than 255 characters" do
      fake = @calendar.dup
      fake.send("#{property}=", (0...256).map { ('a'..'z').to_a[rand(26)] }.join)
      assert_not fake.valid?
      assert fake.errors.details[property].map { |err| err[:error] }.include?(:too_long)
    end
  end
end
