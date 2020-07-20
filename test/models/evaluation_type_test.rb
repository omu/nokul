# frozen_string_literal: true

require 'test_helper'

class EvaluationTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  has_many :course_evaluation_types, dependent: :destroy
  has_many :available_courses, through: :course_evaluation_types

  # validations: presence
  validates_presence_of :name
  validates_presence_of :identifier

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :identifier

  # validations: length
  validates_length_of :name
  validates_length_of :identifier

  # callbacks
  before_validation :capitalize_attributes
end
