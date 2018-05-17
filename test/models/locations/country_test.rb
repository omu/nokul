# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # relational tests for the related models of country
  %i[
    regions
    cities
    districts
    units
  ].each do |property|
    test "a country can communicate with #{property}" do
      assert countries(:turkey).send(property)
    end
  end

  # nullify tests
  test 'region nullifies the country_id when a country gets deleted' do
    countries(:sweden).destroy
    assert_nil regions(:east_sweden).country_id
  end

  # validation tests for the presence of listed properties
  %i[
    name
    iso
    code
  ].each do |property|
    test "presence validations for #{property} of a country" do
      countries(:turkey).send("#{property}=", nil)
      refute countries(:turkey).valid?
      refute_empty countries(:turkey).errors[property]
    end
  end

  # validation tests for the uniqueness of listed properties
  %i[
    name
    iso
    code
  ].each do |property|
    test "uniqueness validations for #{property} of a country" do
      fake = countries(:turkey).dup
      refute fake.valid?
      refute_empty fake.errors[property]
    end
  end

  # callback tests
  test 'callbacks must titlecase the name and must upcase the iso codes of a country' do
    country = Country.create(name: 'wonderland of alice', iso: 'wl1', code: 1)
    assert_equal country.name, 'Wonderland Of Alice'
    assert_equal country.iso, 'WL1'
  end
end
