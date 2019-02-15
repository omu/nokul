# frozen_string_literal: true

require 'test_helper'

class CourseGroupTypeTest < ActiveSupport::TestCase
  include AssociationTestModule

  setup do
    @course_group_type = course_group_types(:one)
  end

  # relations
  has_many :course_groups

  # validations: presence
  test 'should not save course group type without name' do
    @course_group_type.name = nil
    assert_not @course_group_type.valid?
    assert_not_empty @course_group_type.errors[:name]
  end

  # validations: uniqueness
  test 'uniqueness validations for name of a course group type' do
    fake = @course_group_type.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
