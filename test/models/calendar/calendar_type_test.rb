# frozen_string_literal: true

require 'test_helper'

class CalendarTypeTest < ActiveSupport::TestCase
  # presence validation tests
  test 'should not save calendar_type without name' do
    calendar_types(:lisans_önlisans).name = nil
    assert_not calendar_types(:lisans_önlisans).valid?
    refute_empty calendar_types(:lisans_önlisans).errors[:name]
  end

  # relational tests
  %i[
    titles
    calendar_title_types
  ].each do |property|
    test "a calendar type can communicate with #{property}" do
      calendar_types(:lisans_önlisans).send(property)
    end
  end

  # duplication tests
  test 'name should be unique' do
    assert_not calendar_types(:lisans_önlisans).dup.valid?
  end
end
