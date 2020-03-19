# frozen_string_literal: true

require 'test_helper'

class StandardTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  has_many :unit_standards, dependent: :destroy

  # validations: presence
  validates_presence_of :version
  validates_presence_of :name

  # validations: length
  validates_length_of :version, maximum: 50
  validates_length_of :name, maximum: 255

  # validations: uniqueness
  test 'uniqueness validations for name of a standard' do
    fake = standards(:fedek).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end
end
