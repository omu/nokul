# frozen_string_literal: true

require 'test_helper'

class AvailableCourseGroupTest < ActiveSupport::TestCase
  # relations
  %i[
    available_course
    lecturers
  ].each do |property|
    test "a available_course_group can communicate with #{property}" do
      assert available_course_groups(:ati_group_1).send(property)
    end
  end

  # validations: presence
  test 'should not save available_course_group without name' do
    available_course_groups(:ati_group_1).name = nil
    assert_not available_course_groups(:ati_group_1).valid?
    assert_not_empty available_course_groups(:ati_group_1).errors[:name]
  end

  # validations: uniqueness
  test 'name should be unique' do
    fake = available_course_groups(:ati_group_1).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
