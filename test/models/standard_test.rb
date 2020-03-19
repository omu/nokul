# frozen_string_literal: true

require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :accreditation_standard
  has_many :macro_outcomes, class_name: 'Outcome', inverse_of: :standard
  has_many :outcomes, dependent: :destroy
  has_many :unit_standards, dependent: :destroy
  has_many :units, through: :unit_standards

  # delegates
  test 'a standard reach accreditation standard name parameter' do
    assert standards(:one).send(:name)
  end
end
