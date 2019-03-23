# frozen_string_literal: true

require 'test_helper'

class DuplicateCalendarServiceTest < ActiveSupport::TestCase
  test 'can create duplicates of a calendar by adding a prefix' do
    @duplicate_record = AcademicCalendars::DuplicateCalendarService.new(calendars(:uzem_calendar), 'name').duplicate
    assert @duplicate_record.name.starts_with?('[Kopyası]')
  end
end
