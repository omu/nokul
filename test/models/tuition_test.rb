# frozen_string_literal: true

require 'test_helper'

class TuitionTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :academic_term
  has_many :unit_tuitions, dependent: :destroy
  has_many :units, through: :unit_tuitions

  # validations: numericality
  validates_numericality_of :fee
  validates_numericality_of :foreign_student_fee
  validates_numerical_range :fee, greater_than_or_equal_to: 0
  validates_numerical_range :foreign_student_fee, greater_than_or_equal_to: 0
end
