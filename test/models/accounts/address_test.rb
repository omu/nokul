# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'type column does not refer to STI' do
    assert_empty Identity.inheritance_column
  end

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

  # validations: uniqueness
  test 'a user can only have one formal and one informal address' do
    formal = addresses(:formal).dup
    informal = addresses(:informal).dup
    assert_not formal.valid?
    assert_not informal.valid?
    assert_not_empty formal.errors[:type]
    assert_not_empty informal.errors[:type]
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
    addresses(:formal).update!(full_address: 'ABC SOKAK', type: 'informal')
    assert_equal addresses(:formal).full_address, 'Abc Sokak'
  end

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
