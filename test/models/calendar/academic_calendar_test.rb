# frozen_string_literal: true

require 'test_helper'

class AcademicCalendarTest < ActiveSupport::TestCase
  test 'should not save academic calendar without name' do
    academic_calendars(:one).name = nil
    assert_not academic_calendars(:one).valid?
  end

  test 'should not save academic calendar without senate_decision_date' do
    academic_calendars(:one).senate_decision_date = nil
    assert_not academic_calendars(:one).valid?
  end

  test 'should not save academic calendar without senate_decision_no' do
    academic_calendars(:one).senate_decision_no = nil
    assert_not academic_calendars(:one).valid?
  end

  test 'academic_term should be unique based on calendar_type' do
    assert_not academic_calendars(:one).dup.valid?
  end

  test 'should contain calendar events' do
    assert academic_calendars(:one).calendar_events
  end

  test 'should belongs to academic term' do
    assert academic_calendars(:one).academic_term
  end

  test 'should belongs to calendar type' do
    assert academic_calendars(:one).calendar_type
  end
end
