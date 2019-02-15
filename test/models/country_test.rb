# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :addresses
  has_many :cities
  has_many :districts
  has_many :units

  # validations: presence
  %i[
    name
    alpha_2_code
    alpha_3_code
    numeric_code
  ].each do |property|
    test "presence validations for #{property} of a country" do
      countries(:turkey).send("#{property}=", nil)
      assert_not countries(:turkey).valid?
      assert_not_empty countries(:turkey).errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    alpha_2_code
    alpha_3_code
    numeric_code
    mernis_code
  ].each do |property|
    test "uniqueness validations for #{property} of a country" do
      fake = countries(:turkey).dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name and must upcase the iso codes of a country' do
    country = Country.create(name: 'wonderland of alice', alpha_2_code: 'wl', alpha_3_code: 'wlx', numeric_code: 123)
    assert_equal country.name, 'Wonderland Of Alice'
    assert_equal country.alpha_2_code, 'WL'
    assert_equal country.alpha_3_code, 'WLX'
  end

  # other validations
  test 'name can not be longer than 255 characters' do
    fake = countries(:turkey).dup
    fake.name = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
  end

  test 'alpha_2_code must be 2 characters' do
    fake = countries(:turkey).dup
    fake.alpha_2_code = (0...3).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:alpha_2_code].map { |err| err[:error] }.include?(:wrong_length)
  end

  test 'alpha_3_code must be 3 characters' do
    fake = countries(:turkey).dup
    fake.alpha_3_code = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:alpha_3_code].map { |err| err[:error] }.include?(:wrong_length)
  end

  test 'numeric_code must be an integer with 3 digits' do
    fake = countries(:turkey).dup
    fake.numeric_code = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?

    error_codes = fake.errors.details[:numeric_code].map { |err| err[:error] }
    assert error_codes.include?(:wrong_length)
    assert error_codes.include?(:not_a_number)
  end

  test 'mernis_code must be an integer with 4 digits' do
    fake = countries(:turkey).dup
    fake.mernis_code = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?

    error_codes = fake.errors.details[:mernis_code].map { |err| err[:error] }
    assert error_codes.include?(:wrong_length)
    assert error_codes.include?(:not_a_number)
  end

  test 'yoksis_code must be an integer greater than or equal to 0' do
    def error_codes(fake)
      fake.errors.details[:yoksis_code].map { |err| err[:error] }
    end

    fake = countries(:turkey).dup
    fake.yoksis_code = -1
    assert_not fake.valid?
    assert error_codes(fake).include?(:greater_than_or_equal_to)

    fake.yoksis_code = 'hello there!'
    assert_not fake.valid?
    assert error_codes(fake).include?(:not_a_number)
  end
end
