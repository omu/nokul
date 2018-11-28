# frozen_string_literal: true

require 'test_helper'

class CourseGroupTest < ActiveSupport::TestCase
  setup do
    @course_group = course_groups(:one)
  end

  # relations
  %i[
    unit
    course_group_type
    group_courses
    courses
  ].each do |property|
    test "a course unit group can communicate with #{property}" do
      assert @course_group.send(property)
    end
  end

  # validations: presence
  %i[
    name
    total_ects_condition
    course_ids
  ].each do |property|
    test "presence validations for #{property} of a course unit group" do
      @course_group.send("#{property}=", nil)
      assert_not @course_group.valid?
      assert_not_empty @course_group.errors[property]
    end
  end
end
