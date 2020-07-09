# frozen_string_literal: true

require 'test_helper'

class AccreditationStandardTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :accreditation_institution
  has_many :learning_outcomes, dependent: :destroy
  has_many :macro_learning_outcomes, class_name: 'LearningOutcome', inverse_of: :accreditation_standard
  has_many :unit_accreditation_standards, dependent: :destroy
  has_many :units, through: :unit_accreditation_standards

  # validations: presence
  validates_presence_of :version

  # validations: length
  validates_length_of :version, maximum: 50

  # delegates
  test 'a accreditation standard reach accreditation institution name parameter' do
    assert accreditation_standards(:one).public_send(:name)
  end

  # validations: uniqueness
  test 'uniqueness validations for version of a accreditation standard' do
    fake = accreditation_standards(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:version]
  end

  # validations: format
  test 'format validations for version of a accreditation standard' do
    accreditation_standard = accreditation_standards(:one)
    accreditation_standard.version = 'AAA'
    assert_not accreditation_standard.valid?
    accreditation_standard.version = '1.0'
    assert accreditation_standard.valid?
  end
end
