# frozen_string_literal: true

require 'test_helper'

class AcademicCalendarTest < ActiveSupport::TestCase
  # validation tests for the presence of listed properties
  %i[
    name
    senate_decision_date
    senate_decision_no
  ].each do |property|
    test "presence validations for #{property} of a academic calendar" do
      academic_calendars(:one).send("#{property}=", nil)
      refute academic_calendars(:one).valid?
      assert_not_nil academic_calendars(:one).errors[property]
    end
  end

  # relational tests
  %i[
    calendar_events
    academic_term
    calendar_type
  ].each do |property|
    test "an academic calendar can communicate with #{property}" do
      assert academic_calendars(:one).send(property)
    end
  end

  # duplication test
  test 'academic_term should be unique based on calendar_type' do
    assert_not academic_calendars(:one).dup.valid?
  end
end
