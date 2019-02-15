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

  # phone number validations
  test 'Only a valid mobile phone number can be added to address' do
    formal = addresses(:formal).dup

    %w(3623121919 554484377 1234567 55448437700).each do |number|
      formal.phone_number = TelephoneNumber.parse(number, :tr)
      assert_not formal.valid?
      assert_not_empty formal.errors.messages[:phone_number]
    end
  end

  # other validations
  long_string = (0...256).map { ('a'..'z').to_a[rand(26)] }.join

  %i[
    phone_number
    full_address
  ].each do |property|
    test "#{property} can not be longer than 255 characters" do
      fake = addresses(:formal).dup
      fake.send("#{property}=", long_string)
      assert_not fake.valid?
      assert fake.errors.details[property].map { |err| err[:error] }.include?(:too_long)
    end
  end
end
