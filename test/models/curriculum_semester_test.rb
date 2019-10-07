# frozen_string_literal: true

require 'test_helper'

class CurriculumSemesterTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :curriculum, counter_cache: :semesters_count, inverse_of: :semesters
  has_many :curriculum_courses, dependent: :destroy
  has_many :curriculum_course_groups, dependent: :destroy
  has_many :courses, through: :curriculum_courses
  has_many :available_courses, through: :curriculum_courses

  # validations: presence
  validates_presence_of :year
  validates_presence_of :sequence

  # validations: numericality
  validates_numericality_of :sequence
  validates_numerical_range :sequence, greater_than: 0

  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }

  # custom methods
  test 'total_ects method' do
    assert_equal curriculum_semesters(:one).total_ects, 6.0
  end
end
