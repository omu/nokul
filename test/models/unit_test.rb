# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # field tests
  test 'Unit has a type field for single-table inheritance' do
    assert Unit.has_attribute?('type')
  end

  # relational tests
  test 'a unit can communicate with a district' do
    assert units(:omu).district
  end

  test 'a unit can communicate with an unit status' do
    assert units(:omu).unit_status
  end

  test 'a unit can communicate with an unit_instruction_language' do
    assert units(:omu).unit_instruction_language
  end

  test 'a unit can communicate with an unit_instruction_type' do
    assert units(:omu).unit_instruction_type
  end

  test 'a unit can communicate with an university_type' do
    assert units(:omu).university_type
  end

  # validation tests for presence
  test 'presence validations for name of a unit' do
    units(:omu).name = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:name]
  end

  test 'presence validations for yoksis_id of a unit' do
    units(:omu).yoksis_id = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:yoksis_id]
  end

  test 'presence validations for type of a unit' do
    units(:omu).type = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:type]
  end

  test 'presence validations for unit_status relation' do
    units(:omu).unit_status_id = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:unit_status]
  end

  test 'presence validations for unit_instruction_type relation' do
    units(:omu).unit_instruction_type_id = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:unit_instruction_type]
  end

  # validation tests for uniqueness
  test 'uniqueness validations for units' do
    fake = units(:omu).dup
    refute fake.valid?
  end

  test 'uniqueness validations for yoksis_id field of a unit' do
    fake = units(:omu).dup
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
