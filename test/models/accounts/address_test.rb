# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # relations
  %i[
    user
    district
  ].each do |property|
    test "an address can communicate with #{property}" do
      assert addresses(:formal).send(property)
    end
  end

  # validations: presence
  %i[
    name
    full_address
    district
    user
  ].each do |property|
    test "presence validations for #{property} of a user" do
      addresses(:formal).send("#{property}=", nil)
      assert_not addresses(:formal).valid?
      assert_not_empty addresses(:formal).errors[property]
    end
  end

  # validations: uniqueness
  test 'users can not save duplicate addresses' do
    fake = addresses(:formal).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
  end

  # enumerations
  test 'addresses can respond to enumerators' do
    assert addresses(:formal).formal?
    assert addresses(:home).home?
  end

  # callbacks
  test 'callbacks must titlecase the full_address of an address' do
    fake = addresses(:formal).dup
    fake.update!(full_address: 'ABC SOKAK', name: 'other')
    assert_equal fake.full_address, 'Abc Sokak'
  end
end
