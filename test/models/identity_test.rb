# frozen_string_literal: true

require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::EnumerationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  test 'type column does not refer to STI' do
    assert_empty Identity.inheritance_column
  end

  # relations
  belongs_to :student, optional: true
  belongs_to :user

  # validations: presence
  validates_presence_of :date_of_birth
  validates_presence_of :first_name
  validates_presence_of :gender
  validates_presence_of :last_name
  validates_presence_of :place_of_birth
  validates_presence_of :type

  # validations: length
  validates_length_of :fathers_name
  validates_length_of :first_name
  validates_length_of :last_name
  validates_length_of :mothers_name
  validates_length_of :place_of_birth
  validates_length_of :registered_to

  # callbacks
  before_save :capitalize_attributes

  # enums
  enum type: { formal: 1, informal: 2 }
  enum gender: { male: 1, female: 2, other: 3 }
  enum marital_status: { single: 1, married: 2, divorced: 3, unknown: 4 }

  # scopes
  test 'user_identity can return formal identities which does not belongs_to students' do
    assert_equal identities(:formal_user), users(:serhat).identities.user_identity
  end

  # identity validator
  test 'a user can only have one formal user identity' do
    fake = identities(:formal_user).dup
    assert_not fake.valid?
    assert_includes(fake.errors[:base], t('validators.identity.max_formal', limit: 1))
  end

  test 'a user can only have one informal user identity' do
    fake = identities(:informal).dup
    assert_not fake.valid?
    assert_includes(fake.errors[:base], t('validators.identity.max_informal', limit: 1))
  end

  test 'a user can have one formal identity for each studentship' do
    assert identities(:formal_student).valid?
    assert identities(:formal_student_omu).valid?
  end

  # custom methods
  test 'identity can respond to full_name method' do
    identity = identities(:formal_user)
    assert_equal identity.full_name, "#{identity.first_name} #{identity.last_name}"
  end

  test 'identity can respond to country_of_citizenship method' do
    assert_equal identities(:formal_user).country_of_citizenship, countries(:sweden)
    assert_nil   identities(:informal).country_of_citizenship
  end

  test 'identity can respond to city method' do
    assert_equal identities(:formal_user).city, cities(:stockholm)
    assert_nil   identities(:informal).city
  end
end
