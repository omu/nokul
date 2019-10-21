# frozen_string_literal: true

require 'test_helper'

module AcademicCalendars
  class DuplicateServiceTest < ActiveSupport::TestCase
    test 'can create duplicates of a calendar by adding a prefix' do
      duplicate_record = AcademicCalendars::DuplicateService.call(calendars(:uzem_calendar))
      assert duplicate_record.name.starts_with?('[Kopyası]')
    end
  end
end
