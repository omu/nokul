# frozen_string_literal: true

require 'test_helper'

class AcademicCalendarTest < ActiveSupport::TestCase
  # validation tests for the presence of listed properties
  %i[
    name
    senate_decision_date
    senate_decision_no
  ].each do |property|
    test "presence validations for #{property} of an academic calendar" do
      academic_calendars(:lisans_calendar_fall_2017_2018).send("#{property}=", nil)
      refute academic_calendars(:lisans_calendar_fall_2017_2018).valid?
      refute_empty academic_calendars(:lisans_calendar_fall_2017_2018).errors[property]
    end
  end

  # relational tests
  %i[
    calendar_events
    academic_term
    calendar_type
  ].each do |property|
    test "an academic calendar can communicate with #{property}" do
      assert academic_calendars(:lisans_calendar_fall_2017_2018).send(property)
    end
  end

  # duplication test
  test 'academic_term should be unique based on calendar_type' do
    refute academic_calendars(:lisans_calendar_fall_2017_2018).dup.valid?
  end
end
