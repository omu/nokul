# frozen_string_literal: true

require 'test_helper'

class CourseGroupTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @course_group_type = course_group_types(:one)
  end

  # relations
  has_many :course_groups

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  test 'uniqueness validations for name of a course group type' do
    fake = @course_group_type.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
