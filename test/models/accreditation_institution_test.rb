# frozen_string_literal: true

require 'test_helper'

class AccreditationInstitutionTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  has_many :accreditation_standards, dependent: :destroy

  # validations: presence
  validates_presence_of :name

  # validations: length
  validates_length_of :name, maximum: 255

  # validations: uniqueness
  test 'uniqueness validations for name of a accreditation institution' do
    fake = accreditation_institutions(:fedek).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
