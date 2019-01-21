# frozen_string_literal: true

require 'test_helper'

class AvailableCourseGroupTest < ActiveSupport::TestCase
  setup do
    @course_group = available_course_groups(:ati_group_1)
  end

  # relations
  %i[
    available_course
    lecturers
  ].each do |property|
    test "a available_course_group can communicate with #{property}" do
      assert @course_group.send(property)
    end
  end

  # validations: presence
  test 'should not save available_course_group without name' do
    @course_group.name = nil
    assert_not @course_group.valid?
    assert_not_empty @course_group.errors[:name]
  end

  # validations: uniqueness
  test 'name should be unique' do
    fake = @course_group.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
