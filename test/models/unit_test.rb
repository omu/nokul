# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # field tests
  test 'Unit has a type field for single-table inheritance' do
    assert Unit.has_attribute?('type')
  end

  # relational tests for the related models of unit
  %i[
    district
    unit_status
    unit_instruction_language
    unit_instruction_type
    university_type
  ].each do |property|
    test "a unit can communicate with #{property}" do
      assert units(:omu).send(property)
    end
  end

  test 'university can communicate with university_types' do
    assert units(:omu).university_type
  end

  # validation tests for the presence of listed properties
  %i[
    name
    yoksis_id
    type
    unit_status
    unit_instruction_type
  ].each do |property|
    test "presence validations for #{property} of a unit" do
      units(:omu).send("#{property}=", nil)
      refute units(:omu).valid?
      assert_not_nil units(:omu).errors[property]
    end
  end

  test 'uniqueness validations for yoksis_id field of a unit' do
    fake = units(:omu).dup
    refute fake.valid?
    assert_not_nil fake.errors[:yoksis_id]
  end

  test 'callbacks must titlecase the name for a unit' do
    unit = units(:omu).dup
    unit.update(yoksis_id: 1234, name: 'wonderunit department')
    assert_equal unit.name, 'Wonderunit Department'
  end

  # custom tests
  test 'types method can return all models inheriting from the Unit model' do
    types = Unit.types
    assert types.is_a?(Array)
    refute types.empty?
  end
end
