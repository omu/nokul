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
    type
    full_address
  ].each do |property|
    test "presence validations for #{property} of an address user" do
      addresses(:informal).send("#{property}=", nil)
      assert_not addresses(:informal).valid?
      assert_not_empty addresses(:informal).errors[property]
    end
  end

  # enumerations
  test 'addresses can respond to enumerators' do
    assert addresses(:formal).formal?
    assert addresses(:informal).informal?
  end

  # delegations
  test 'address delegates id_number for activejob objects' do
    assert addresses(:formal).id_number
  end

  # callbacks
  test 'callbacks must titlecase the full_address of an address' do
    addresses(:formal).update!(full_address: 'ABC SOKAK', name: 'other')
    assert_equal addresses(:formal).full_address, 'Abc Sokak'
  end

  # address_validator
  test 'a user can only have one formal address' do
    fake = addresses(:formal).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:base]
    assert fake.errors[:base].include?(t('validators.address.max_legal', limit: 1))
  end

  test 'a user can have 5 addresses in total' do
    val = 6 - users(:serhat).addresses.count
    val.times do
      users(:serhat).addresses.create!(
        name: :other,
        phone_number: '123456',
        full_address: 'foobar',
        district: districts(:atakum)
      )
    end

    fake = addresses(:informal).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:base]
    assert fake.errors[:base].include?(t('validators.address.max_total', limit: 5))
  end
end
