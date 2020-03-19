# frozen_string_literal: true

require 'test_helper'

class UnitStandardTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :unit
  belongs_to :standard

  # validations: uniqueness
  test 'uniqueness validations for standard of a unit_standard' do
    fake = unit_standards(:one).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:standard]
  end
end
