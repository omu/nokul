# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # enum tests
  test 'Unit statuses match with YOKSIS values' do
    statuses = Unit.statuses
    assert_equal statuses['passive'], 0
    assert_equal statuses['active'], 1
    assert_equal statuses['partially_passive'], 2
    assert_equal statuses['closed'], 3
    assert_equal statuses['archived'], 4
    assert_equal statuses['unknown'], 5
  end

  test 'Unit instruction types match with YOKSIS values' do
    instruction_types = Unit.instruction_types
    assert_equal instruction_types['formal'], 1
    assert_equal instruction_types['evening'], 2
    assert_equal instruction_types['distance_education'], 3
    assert_equal instruction_types['open_education'], 4
  end

  # field tests
  test 'Unit has a type field for single-table inheritance' do
    assert Unit.has_attribute?('type')
  end

  # relational tests
  test 'a unit can communicate with a city' do
    assert units(:omu).city
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

  test 'presence validations for status of a unit' do
    units(:omu).status = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:status]
  end

  test 'presence validations for type of a unit' do
    units(:omu).type = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:type]
  end

  test 'presence validations for instruction_type of a unit' do
    units(:omu).instruction_type = nil
    refute units(:omu).valid?
    assert_not_nil units(:omu).errors[:instruction_type]
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

  # callback tests for uniqueness
  test 'callbacks must titlecase the name for a unit' do
    unit = Unit.create(
      name: 'wonderunit department',
      yoksis_id: Random.new_seed,
      status: 1,
      type: 'Department',
      instruction_type: 1
    )
    assert_equal unit.name, 'Wonderunit Department'
  end

  # custom tests
  test 'types method can return all models inheriting from the Unit model' do
    types = Unit.types
    assert types.is_a?(Array)
    refute types.empty?
  end
end
