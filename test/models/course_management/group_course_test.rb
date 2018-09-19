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
end
