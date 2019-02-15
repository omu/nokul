# frozen_string_literal: true

require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include EnumerationTestModule

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
  has_enum({ formal: 1, informal: 2 }, 'type')
  has_enum({ male: 1, female: 2, other: 3 }, 'gender')
  has_enum({ single: 1, married: 2, divorced: 3, unknown: 4 }, 'marital_status')

  # scopes
  test 'user_identity can return formal identities which does not belongs_to students' do
    assert_equal identities(:formal_user), users(:serhat).identities.user_identity
  end

  # callbacks
  test 'callbacks must titlecase first_name, mothers_name, fathers_name and place_of_birth of an identity' do
    identity = identities(:formal_user)
    identity.update(
      first_name: 'ışık',
      last_name: 'ılık',
      mothers_name: 'süt',
      fathers_name: 'iç',
      place_of_birth: 'ıişüğ'
    )
    assert_equal identity.first_name, 'Işık'
    assert_equal identity.last_name, 'ILIK'
    assert_equal identity.mothers_name, 'Süt'
    assert_equal identity.fathers_name, 'İç'
    assert_equal identity.place_of_birth, 'Iişüğ'
  end

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
