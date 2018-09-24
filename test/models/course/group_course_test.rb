# frozen_string_literal: true

require 'test_helper'

class GroupCourseTest < ActiveSupport::TestCase
  # relations
  %i[
    course
    course_unit_group
  ].each do |property|
    test "a group course can communicate with #{property}" do
      assert group_courses(:one).send(property)
    end
  end

  # validations: uniqueness
  test 'group_course should be unique based on course' do
    fake_group_course = group_courses(:one).dup
    assert_not fake_group_course.valid?
  end
end
