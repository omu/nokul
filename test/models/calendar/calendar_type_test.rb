# frozen_string_literal: true

require 'test_helper'

class CalendarTypeTest < ActiveSupport::TestCase
  # relations
  %i[
    titles
    calendar_title_types
    academic_calendars
    calendar_unit_types
    unit_types
  ].each do |property|
    test "a calendar type can communicate with #{property}" do
      calendar_types(:lisans_önlisans).send(property)
    end
  end

  # validations: presence
  test 'should not save calendar_type without name' do
    calendar_types(:lisans_önlisans).name = nil
    assert_not calendar_types(:lisans_önlisans).valid?
    assert_not_empty calendar_types(:lisans_önlisans).errors[:name]
  end

  # validations: uniqueness
  test 'name should be unique' do
    assert_not calendar_types(:lisans_önlisans).dup.valid?
  end
end
