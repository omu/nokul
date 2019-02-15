# frozen_string_literal: true

require 'test_helper'

class GroupCourseTest < ActiveSupport::TestCase
  include AssociationTestModule

  # relations
  belongs_to :course
  belongs_to :course_group

  # validations: uniqueness
  test 'group_course should be unique based on course' do
    fake_group_course = group_courses(:one).dup
    assert_not fake_group_course.valid?
  end
end
