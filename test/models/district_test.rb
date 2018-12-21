# frozen_string_literal: true

require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  # relations
  %i[
    city
    units
    addresses
  ].each do |property|
    test "a district can communicate with #{property}" do
      assert districts(:atakum).send(property)
    end
  end

  %i[
    name
    city
  ].each do |property|
    test "presence validations for #{property} of a district" do
      districts(:vezirkopru).send("#{property}=", nil)
      assert_not districts(:vezirkopru).valid?
      assert_not_empty districts(:vezirkopru).errors[property]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for name field of a district, scoped with city' do
    fake = districts(:vezirkopru).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
    assert_not_empty fake.errors[:mernis_code]
  end

  # callbacks
  test 'callbacks must titlecase the name of a district' do
    district = District.create!(name: 'wonderland of samsun', city: cities(:samsun), active: true)
    assert_equal district.name, 'Wonderland Of Samsun'
  end

  # other validations
  test "name can not be longer than 255 characters" do
    fake = districts(:vezirkopru).dup
    fake.name = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:name].map{|err| err[:error]}.include?(:too_long)
  end

  test "mernis_code must be an integer with 4 digits" do
    fake = districts(:vezirkopru).dup
    fake.mernis_code = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?

    error_codes = fake.errors.details[:mernis_code].map{|err| err[:error]}
    assert error_codes.include?(:wrong_length)
    assert error_codes.include?(:not_a_number)
  end

  test "active field can not be nil" do
    fake = districts(:vezirkopru).dup
    fake.active = nil
    assert_not fake.valid?

    error_codes = fake.errors.details[:active].map{|err| err[:error]}
    assert error_codes.include?(:inclusion)
  end
end
