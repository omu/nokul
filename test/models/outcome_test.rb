# frozen_string_literal: true

require 'test_helper'

class OutcomeTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :unit_standard
  belongs_to :macro_outcome, class_name: 'Outcome', foreign_key: :parent_id,
                             inverse_of: :micro_outcomes, optional: true
  has_many :micro_outcomes, class_name: 'Outcome', foreign_key: :parent_id,
                            inverse_of: :macro_outcome, dependent: :destroy
  accepts_nested_attributes_for :micro_outcomes, allow_destroy: true

  # validations: presence
  validates_presence_of :code
  validates_presence_of :name

  # validations: length
  validates_length_of :code, maximum: 10
  validates_length_of :name, maximum: 255

  # validations: uniqueness
  test 'uniqueness validations for code of a outcome' do
    fake = outcomes(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:code]
  end

  # delegates
  test 'a outcome reach unit parameter' do
    assert outcomes(:one).unit
  end

  # scopes
  test 'ordered returns outcomes ordered by code' do
    outcomes = unit_standards(:one).macro_outcomes.ordered
    assert_equal outcomes(:one), outcomes.first
    assert_equal outcomes(:four), outcomes.last
  end
end
