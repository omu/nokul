# frozen_string_literal: true

require 'test_helper'

class CourseAssessmentMethodTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum status: { no_grade_entered: 0, draft: 1 }

  # relations
  belongs_to :assessment_method
  belongs_to :course_evaluation_type
  has_many :grades, dependent: :destroy
  accepts_nested_attributes_for :grades

  # validations: presence
  validates_presence_of :percentage

  # validations: uniqueness
  validates_uniqueness_of :assessment_method

  # validations: numericality
  validates_numericality_of :percentage
  validates_numerical_range :percentage, greater_than_or_equal_to: 0
  validates_numerical_range :percentage, less_than_or_equal_to: 100

  # delegates
  %i[
    available_course
    name
  ].each do |property|
    test "a course_assessment_method reach #{property} parameter" do
      assert course_assessment_methods(:elective_midterm_project_assessment).send(property)
    end
  end

  # custom methods
  test 'grades_under_authority_of employee method' do
    grades = course_assessment_methods(:elective_midterm_project_assessment)
             .grades_under_authority_of(employees(:serhat_active))
    assert_includes grades, grades(:elective_midterm_project_grade)
    assert_not_includes grades, grades(:johns_elective_midterm_project_grade)
  end

  test 'build_grades_for enrollments method' do
    assessment = course_assessment_methods(:elective_midterm_project_assessment)
    enrollments = available_courses(:elective_course).enrollments_under_authority_of(employees(:serhat_active))
    assert_equal enrollments.pluck(:id), assessment.build_grades_for(enrollments).pluck(:course_enrollment_id)
  end
end
