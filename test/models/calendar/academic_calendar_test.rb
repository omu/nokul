# frozen_string_literal: true

require 'test_helper'

class AcademicCalendarTest < ActiveSupport::TestCase
  test 'should not save academic calendar without name' do
    academic_calendars(:one).name = nil
    assert_not academic_calendars(:one).valid?
  end

  test 'should not save academic calendar without senatus_consultum_no' do
    academic_calendars(:one).senatus_consultum_no = nil
    assert_not academic_calendars(:one).valid?
  end

  test 'academic_term should be unique based on calendar_type' do
    assert_not academic_calendars(:one).dup.valid?
  end
end
