# frozen_string_literal: true

require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :accreditation_institution
  has_many :macro_outcomes, class_name: 'Outcome', inverse_of: :standard
  has_many :outcomes, dependent: :destroy
  has_many :unit_standards, dependent: :destroy
  has_many :units, through: :unit_standards

  # validations: presence
  validates_presence_of :version

  # validations: length
  validates_length_of :version, maximum: 50

  # delegates
  test 'a standard reach accreditation institution name parameter' do
    assert standards(:one).send(:name)
  end

  # validations: uniqueness
  test 'uniqueness validations for version of a standard' do
    fake = standards(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:version]
  end
end
