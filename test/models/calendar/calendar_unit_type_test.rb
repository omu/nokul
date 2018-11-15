# frozen_string_literal: true

require 'test_helper'

class CalendarUnitTypeTest < ActiveSupport::TestCase
  # relations
  %i[
    calendar_type
    unit_type
  ].each do |property|
    test "a calendar unit type can communicate with #{property}" do
      assert calendar_unit_types(:one).send(property)
    end
  end
end
