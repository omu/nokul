# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # relations
  %i[
    district
    unit_status
    unit_type
    unit_instruction_type
    unit_instruction_language
    university_type
    duties
    employees
    students
    positions
    administrative_functions
  ].each do |property|
    test "a unit can communicate with #{property}" do
      assert units(:omu).send(property)
    end
  end

  # validations: presence
  %i[
    district
    name
    unit_status
  ].each do |property|
    test "presence validations for #{property} of a unit" do
      units(:omu).send("#{property}=", nil)
      assert_not units(:omu).valid?
      assert_not_empty units(:omu).errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    yoksis_id
    detsis_id
  ].each do |property|
    test "uniqueness validations for #{property} of a unit" do
      fake = units(:omu).dup
      assert_not fake.valid?
    end
  end

  # callbacks
  test 'callbacks must titlecase the name for a unit' do
    unit = units(:omu).dup
    unit.update!(yoksis_id: 1234, name: 'wonderunit department')
    assert_equal unit.name, 'Wonderunit Department'
  end

  # search
  test 'unit is a searchable model' do
    assert_not_empty Unit.search('Ondokuz')
    assert Unit.search('Ondokuz').include?(units(:omu))
    assert_not Unit.search('Ondokuz').include?(units(:uzem))
  end
end
