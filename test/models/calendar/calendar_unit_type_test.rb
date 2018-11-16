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

  # validations: uniqueness
  test 'uniqueness validations for calendar type of a unit_type' do
    fake = calendar_unit_types(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:unit_type]
    fake.calendar_type = calendar_types(:yuksek_lisans)
    assert fake.valid?
  end
end
