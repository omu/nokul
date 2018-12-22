# frozen_string_literal: true

require 'test_helper'

class CalendarUnitTest < ActiveSupport::TestCase
  # relations
  %i[
    academic_calendar
    unit
  ].each do |property|
    test "a calendar unit can communicate with #{property}" do
      assert calendar_units(:one).send(property)
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for academic calendar of a unit' do
    fake = calendar_units(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:unit]
    fake.academic_calendar = academic_calendars(:lisans_calendar_spring_2017_2018)
    assert fake.valid?
  end
end
