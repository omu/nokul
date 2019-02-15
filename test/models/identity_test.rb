# frozen_string_literal: true

require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  test 'type column does not refer to STI' do
    assert_empty Identity.inheritance_column
  end

  # relations
  belongs_to :user

  # validations: presence
  validates_presence_of :type
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :gender
  validates_presence_of :place_of_birth
  validates_presence_of :date_of_birth

  # validations: uniqueness
  test 'an identity can not belong to multiple students' do
    student_identity = identities(:formal_student).dup
    assert_not student_identity.valid?
    assert_not_empty student_identity.errors[:student_id]
  end

  # other validations
  long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join

  %i[
    first_name
    last_name
    mothers_name
    fathers_name
    place_of_birth
    registered_to
  ].each do |property|
    test "#{property} can not be longer than 255 characters" do
      fake = identities(:formal_user).dup
      fake.send("#{property}=", long_string)
      assert_not fake.valid?
      assert fake.errors.details[property].map { |err| err[:error] }.include?(:too_long)
    end
  end

  # enumerations
  %i[
    formal?
    male?
    married?
  ].each do |property|
    test "identities can respond to #{property} enum" do
      assert identities(:formal_user).send(property)
    end
  end

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
