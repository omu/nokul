# frozen_string_literal: true

require 'test_helper'

class CourseUnitGroupTest < ActiveSupport::TestCase
  # relations
  %i[
    unit
    course_group_type
  ].each do |property|
    test "a course unit group can communicate with #{property}" do
      assert course_unit_groups(:one).send(property)
    end
  end

  # validations: presence
  %i[
    name
    total_akts_condition
  ].each do |property|
    test "presence validations for #{property} of a course unit group" do
      course_unit_groups(:one).send("#{property}=", nil)
      assert_not course_unit_groups(:one).valid?
      assert_not_empty course_unit_groups(:one).errors[property]
    end
  end
end
