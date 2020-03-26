# frozen_string_literal: true

require 'test_helper'

class TuitionDebtTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :student
  belongs_to :academic_term
  belongs_to :unit_tuition

  # validations
  validates_numerical_range :amount, greater_than: 0
  validates_length_of :description, maximum: 65_535
end
