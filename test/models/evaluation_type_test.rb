# frozen_string_literal: true

require 'test_helper'

class EvaluationTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include CallbackTestModule

  # relations
  has_many :course_evaluation_types, dependent: :destroy
  has_many :available_courses, through: :course_evaluation_types

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # callbacks
  has_validation_callback :capitalize_attributes, :before
end
