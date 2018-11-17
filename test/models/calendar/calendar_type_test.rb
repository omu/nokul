# frozen_string_literal: true

require 'test_helper'

class CalendarTypeTest < ActiveSupport::TestCase
  setup do
    @calendar_type = calendar_types(:lisans_onlisans)
  end

  # relations
  %i[
    titles
    calendar_title_types
    academic_calendars
    calendar_unit_types
    unit_types
    calendar_events
  ].each do |property|
    test "a calendar type can communicate with #{property}" do
      @calendar_type.send(property)
    end
  end

  # validations: presence
  test 'should not save calendar_type without name' do
    @calendar_type.name = nil
    assert_not @calendar_type.valid?
    assert_not_empty @calendar_type.errors[:name]
  end

  # validations: uniqueness
  test 'name should be unique' do
    assert_not @calendar_type.dup.valid?
  end
end
