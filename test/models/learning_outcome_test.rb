# frozen_string_literal: true

require 'test_helper'

class LearningOutcomeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :accreditation_standard
  belongs_to :macro, class_name: 'LearningOutcome', foreign_key: :parent_id,
                     inverse_of: :micros, optional: true
  has_many :micros, class_name: 'LearningOutcome', foreign_key: :parent_id,
                    inverse_of: :macro, dependent: :destroy
  accepts_nested_attributes_for :micros, allow_destroy: true

  # validations: presence
  validates_presence_of :code
  validates_presence_of :name

  # validations: length
  validates_length_of :code, maximum: 10
  validates_length_of :name, maximum: 255

  # validations: uniqueness
  test 'uniqueness validations for code of a learning outcome' do
    fake = learning_outcomes(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:code]
  end

  # scopes
  test 'ordered returns learning outcomes ordered by code' do
    learning_outcomes = accreditation_standards(:one).macro_learning_outcomes.ordered
    assert_equal learning_outcomes(:one), learning_outcomes.first
    assert_equal learning_outcomes(:four), learning_outcomes.last
  end
end
