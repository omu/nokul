# frozen_string_literal: true

require 'test_helper'

class AvailableCourseTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper

  # relations
  belongs_to :academic_term
  belongs_to :coordinator, class_name: 'Employee'
  belongs_to :course
  belongs_to :curriculum
  belongs_to :unit
  has_many :evaluation_types, class_name: 'CourseEvaluationType', dependent: :destroy
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy
  has_many :lecturers, through: :groups
  accepts_nested_attributes_for :groups, allow_destroy: true

  # callbacks
  before_validation :assign_academic_term

  # validations: uniqueness
  test 'uniqueness validations for available_course of a course' do
    fake = available_courses(:ati_fall_2018_2019).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:course]
  end
end
