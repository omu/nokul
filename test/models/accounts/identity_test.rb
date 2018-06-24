# frozen_string_literal: true

require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  # relations
  %i[
    user
    student
  ].each do |property|
    test "an identity can communicate with #{property}" do
      assert identities(:serhat_formal).send(property)
    end
  end

  # validations: presence
  %i[
    name
    first_name
    last_name
    gender
    place_of_birth
    date_of_birth
  ].each do |property|
    test "presence validations for #{property} of a user" do
      identities(:serhat_formal).send("#{property}=", nil)
      assert_not identities(:serhat_formal).valid?
      assert_not_empty identities(:serhat_formal).errors[property]
    end
  end

  # enumerations
  %i[
    formal?
    male?
    married?
  ].each do |property|
    test "identities can respond to #{property} enum" do
      assert identities(:serhat_formal).send(property)
    end
  end

  # callbacks
  test 'callbacks must titlecase first_name, mothers_name, fathers_name and place_of_birth of an identity' do
    identity = identities(:serhat_formal)
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
  test 'a user can only have one legal identity' do
    fake = identities(:serhat_formal).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:base]
    assert fake.errors[:base].include?(t('validators.identity.max_legal', limit: 1))
  end

  test 'a user can have 2 identities in total' do
    fake = identities(:serhat_informal).dup
    fake.save
    fake = identities(:serhat_informal).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:base]
    assert fake.errors[:base].include?(t('validators.identity.max_total', limit: 2))
  end
end
