# frozen_string_literal: true

require 'test_helper'

module Actions
  module AcademicCalendar
    class DuplicateTest < ActiveSupport::TestCase
      focus
      test 'can create duplicates of a calendar by adding a prefix' do
        byebug
        record = Actions::AcademicCalendar::Duplicate.call(calendars(:uzem_calendar))
        assert record.name.starts_with?('[Kopyası]')
      end
    end
  end
end
