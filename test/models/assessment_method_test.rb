# frozen_string_literal: true

require 'test_helper'

class AssessmentMethodTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  has_many :course_assessment_methods, dependent: :destroy
  has_many :course_evaluation_types, through: :course_assessment_methods
  has_many :available_courses, through: :course_evaluation_types

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # callbacks
  before_validation :capitalize_attributes
end
