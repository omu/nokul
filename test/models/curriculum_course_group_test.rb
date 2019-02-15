# frozen_string_literal: true

require 'test_helper'

class CurriculumCourseGroupTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @curriculum_course_group = curriculum_course_groups(:one)
  end

  # relations
  has_many :curriculum_courses
  has_many :courses
  belongs_to :course_group
  belongs_to :curriculum_semester

  # validations: presence
  {
    course_group_id: :course_group,
    curriculum_semester_id: :curriculum_semester,
    ects: :ects
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a curriculum course group" do
      @curriculum_course_group.send("#{property}=", nil)
      assert_not @curriculum_course_group.valid?
      assert_not_empty @curriculum_course_group.errors[error_message_key]
    end
  end

  # validations: uniqueness
  validates_uniqueness_of :course_group_id

  # validations: numericality
  test 'numericality validations for ects of a curriculum course group' do
    @curriculum_course_group.ects = 0
    assert_not @curriculum_course_group.valid?
    assert_not_empty @curriculum_course_group.errors[:ects]
  end

  # delegates
  test 'must have a name method' do
    assert_equal @curriculum_course_group.name, @curriculum_course_group.course_group.name
  end
end
