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
    iso
    code
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
    iso
    code
  ].each do |property|
    test "uniqueness validations for #{property} of a country" do
      fake = countries(:turkey).dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name and must upcase the iso codes of a country' do
    country = Country.create(name: 'wonderland of alice', iso: 'wl1', code: 1)
    assert_equal country.name, 'Wonderland Of Alice'
    assert_equal country.iso, 'WL1'
  end
end
