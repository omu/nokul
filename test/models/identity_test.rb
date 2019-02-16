# frozen_string_literal: true

require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include EnumerationTestModule
  include ValidationTestModule

  test 'type column does not refer to STI' do
    assert_empty Identity.inheritance_column
  end

  # relations
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

  # validations: uniqueness
  test 'an identity can not belong to multiple students' do
    student_identity = identities(:formal_student).dup
    assert_not student_identity.valid?
    assert_not_empty student_identity.errors[:student_id]
  end

  # enums
  has_enum :type, values: { formal: 1, informal: 2 }
  has_enum :gender, values: { male: 1, female: 2, other: 3 }
  has_enum :marital_status, values: { single: 1, married: 2, divorced: 3, unknown: 4 }

  # scopes
  test 'user_identity can return formal identities which does not belongs_to students' do
    assert_equal identities(:formal_user), users(:serhat).identities.user_identity
  end

  # callbacks
  has_save_callback :capitalize_attributes, :before

  # identity validator
  test 'a user can only have one formal user identity' do
    fake = identities(:formal_user).dup
    assert_not fake.valid?
    assert fake.errors[:base].include?(t('validators.identity.max_formal', limit: 1))
  end

  test 'a user can only have one informal user identity' do
    fake = identities(:informal).dup
    assert_not fake.valid?
    assert fake.errors[:base].include?(t('validators.identity.max_informal', limit: 1))
  end

  test 'a user can have one formal identity for each studentship' do
    assert identities(:formal_student).valid?
    assert identities(:formal_student_omu).valid?
  end
end
