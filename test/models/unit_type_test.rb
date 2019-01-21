# frozen_string_literal: true

require 'test_helper'

class UnitTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_types(:university)
  end

  # relations
  %i[
    units
  ].each do |property|
    test "a unit_type can communicate with #{property}" do
      assert @object.send(property)
    end
  end

  # enums
  {
    group: {
      other: 0,
      faculty: 1,
      department: 2,
      major: 3,
      undergraduate_program: 4,
      graduate_program: 5,
      institute: 6,
      research_center: 7,
      committee: 8,
      administrative: 9
    }
  }.each do |property, hash|
    hash.each do |key, value|
      test "have a #{key} value of #{property} enum" do
        enums = UnitType.defined_enums.with_indifferent_access
        assert_equal enums.dig(property, key), value
      end
    end
  end
end
