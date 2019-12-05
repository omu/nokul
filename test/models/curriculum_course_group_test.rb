# frozen_string_literal: true

require 'test_helper'

class CurriculumCourseGroupTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :course_group
  belongs_to :curriculum_semester
  has_many :curriculum_courses, dependent: :destroy
  has_many :courses, through: :curriculum_courses
  has_many :available_courses, through: :curriculum_courses

  # validations: presence
  validates_presence_of :course_group
  validates_presence_of :curriculum_semester
  validates_presence_of :ects

  # validations: uniqueness
  validates_uniqueness_of :course_group_id

  # validations: numericality
  validates_numericality_of :ects
  validates_numerical_range :ects, greater_than: 0

  # delegates
  test 'must have a name method' do
    assert_equal curriculum_course_groups(:one).name, curriculum_course_groups(:one).course_group.name
  end
end
