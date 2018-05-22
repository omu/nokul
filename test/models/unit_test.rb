# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # fields
  test 'Unit has a type field for single-table inheritance' do
    assert Unit.has_attribute?('type')
  end

  # relations
  %i[
    district
    unit_status
    unit_instruction_type
    unit_instruction_language
    university_type
    duties
    employees
    students
  ].each do |property|
    test "a unit can communicate with #{property}" do
      assert units(:omu).send(property)
    end
  end

  test 'university can communicate with university_types' do
    assert units(:omu).university_type
  end

  # validations: presence
  %i[
    type
    district
    unit_status
    yoksis_id
    name
  ].each do |property|
    test "presence validations for #{property} of a unit" do
      units(:omu).send("#{property}=", nil)
      assert_not units(:omu).valid?
      assert_not_empty units(:omu).errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for yoksis_id and name fields of a unit' do
    fake = units(:omu).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:yoksis_id]
    assert_not_empty fake.errors[:name]
  end

  # callbacks
  test 'callbacks must titlecase the name for a unit' do
    unit = units(:omu).dup
    unit.update(yoksis_id: 1234, name: 'wonderunit department')
    assert_equal unit.name, 'Wonderunit Department'
  end

  # custom tests
  test 'types method can return all models inheriting from the Unit model' do
    types = Unit.types
    assert types.is_a?(Array)
    assert_not types.empty?
  end
end
