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

  # identity validator
  test 'a user can only have one legal identity' do
    fake = identities(:serhat_formal).dup
    fake.save
    assert_not_empty fake.errors[:base]
  end
end
