# frozen_string_literal: true

require 'test_helper'

class UnitCalendarTest < ActiveSupport::TestCase
  # relations
  %i[
    unit
    calendar
  ].each do |property|
    test "unit calendar can communicate with #{property}" do
      assert unit_calendars(:uzem_calendar).send(property)
    end
  end
end
