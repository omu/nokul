# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # relations
  %i[
    employees
    students
    identities
    addresses
  ].each do |property|
    test "a user can communicate with #{property}" do
      assert users(:serhat).send(property)
    end
  end

  %i[
    email
    id_number
  ].each do |property|
    # validations: presence
    test "presence validations for #{property} of a user" do
      users(:serhat).send("#{property}=", nil)
      assert_not users(:serhat).valid?
      assert_not_empty users(:serhat).errors[property]
    end

    # validations: uniqueness
    test "uniqueness validations for #{property} of a user" do
      fake = users(:serhat).dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # validations: numerically
  test 'id_number must be numeric' do
    fake = users(:serhat).dup
    ['abc', '.,', '1,24', '10.25'].each do |value|
      fake.id_number = value
      assert_not fake.valid?
      assert_not_empty fake.errors[:id_number]
    end
  end

  # validations: length
  test 'id_number must be 11 characters' do
    fake = users(:serhat).dup
    ['123456789121', '123', '123456789,5', '14254455.77'].each do |value|
      fake.id_number = value
      assert_not fake.valid?
      assert_not_empty fake.errors[:id_number]
    end
  end

  # validations: email
  test 'email addresses validated against RFC' do
    fake = users(:serhat).dup
    [
      'Abc\@def@example.com',
      'Fred\ Bloggs@example.com',
      'Joe.\\Blow@example.com',
      '"Abc@def"@example.com',
      '"Fred Bloggs"@example.com',
      'customer/department=shipping@example.com',
      '$A12345@example.com',
      '!def!xyz%abc@example.com',
      '_somename@example.com'
    ].each do |email|
      fake.email = email
      assert_not fake.valid?
      assert_not_empty fake.errors[:id_number]
    end
  end

  # custom tests
  test 'user can respond to account method' do
    assert users(:serhat).accounts
  end
end
