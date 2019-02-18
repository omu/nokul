# frozen_string_literal: true

require 'test_helper'

class AvailableCourseTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule

  # relations
  belongs_to :academic_term
  belongs_to :coordinator, class_name: 'Employee'
  belongs_to :course
  belongs_to :curriculum
  belongs_to :unit
  has_many :evaluation_types, class_name: 'CourseEvaluationType', dependent: :destroy
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy

  # callbacks
  has_validation_callback :assign_academic_term, :before

  # validations: uniqueness
  test 'uniqueness validations for course of a academic term and curriculum' do
    fake = available_courses(:ati_fall_2018_2019).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:course]
    fake.course = courses(:ydi)
    assert fake.valid?
    fake.academic_term = academic_terms(:fall_2017_2018)
    fake.curriculum = curriculums(:two)
    assert fake.valid?
  end
end
