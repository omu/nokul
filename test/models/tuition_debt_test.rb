# frozen_string_literal: true

require 'test_helper'

class TuitionDebtTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum description: { disability: 1, no_discount: 2 }
  enum type: { personal: 1, bulk: 2 }

  # relations
  belongs_to :student
  belongs_to :academic_term
  belongs_to :unit_tuition
  has_one    :unit

  # validations
  validates_numerical_range :amount, greater_than: 0
  validates_presence_of :due_date
end
