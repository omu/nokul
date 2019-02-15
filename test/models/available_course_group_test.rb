# frozen_string_literal: true

require 'test_helper'

class AvailableCourseGroupTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @course_group = available_course_groups(:ati_group_1)
  end

  # relations
  belongs_to :available_course
  has_many :lecturers

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  test 'name should be unique' do
    fake = @course_group.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
