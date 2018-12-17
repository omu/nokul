# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # relations
  %i[
    cities
    districts
    addresses
    units
  ].each do |property|
    test "a country can communicate with #{property}" do
      assert countries(:turkey).send(property)
    end
  end

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
end
