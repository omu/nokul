# frozen_string_literal: true

require 'test_helper'

class UnitStandardTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper
  
  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :standard
  belongs_to :unit
  has_many :outcomes, dependent: :destroy
  has_many :macro_outcomes, class_name: 'Outcome', inverse_of: :unit_standard

  # validations: presence
  validates_presence_of :standard

  # validations: uniqueness
  test 'uniqueness validations for status of a unit standard' do
    fake = unit_standards(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:status]
  end
end
