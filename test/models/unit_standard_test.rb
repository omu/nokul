# frozen_string_literal: true

require 'test_helper'

class UnitStandardTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :unit
  belongs_to :accreditation_standard

  # validations: uniqueness
  test 'uniqueness validations for accreditation standard of a unit standard' do
    fake = unit_standards(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:accreditation_standard]
  end
end
