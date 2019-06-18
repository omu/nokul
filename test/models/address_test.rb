# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  test 'type column does not refer to STI' do
    assert_empty Identity.inheritance_column
  end

  # relations
  belongs_to :district
  belongs_to :user

  # validations: presence
  validates_presence_of :full_address
  validates_presence_of :type

  # validations: uniqueness
  validates_uniqueness_of :type

  # validations: length
  validates_length_of :full_address

  # enumerations
  enum type: { formal: 1, informal: 2 }

  # callbacks
  before_save :capitalize_attributes

  # address_validator
  test 'a user can only have one formal address' do
    formal = addresses(:formal).dup
    assert_not formal.valid?
    assert_not_empty formal.errors[:base]
    assert formal.errors[:base].include?(t('validators.address.max_formal', limit: 1))
  end

  test 'a user can only have one informal address' do
    informal = addresses(:informal).dup
    assert_not informal.valid?
    assert_not_empty informal.errors[:base]
    assert informal.errors[:base].include?(t('validators.address.max_informal', limit: 1))
  end
end
