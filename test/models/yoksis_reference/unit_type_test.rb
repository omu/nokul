# frozen_string_literal: true

require 'test_helper'

class UnitTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_types(:university)
  end

  # relations
  test 'unit_type can communicate with units' do
    assert @object.units
  end

  # enums
  {
    group: { other: 0, university: 1, faculty: 2, department: 3, program: 4, committee: 5 }
  }.each do |property, hash|
    hash.each do |key, value|
      test "have a #{key} value of #{property} enum" do
        enums = UnitType.defined_enums.with_indifferent_access
        assert_equal enums.dig(property, key), value
      end
    end
  end
end
