# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # relational tests
  test 'a country can communicate with regions' do
    assert countries(:turkey).regions
  end

  test 'a country can communicate with cities' do
    assert countries(:turkey).cities
  end

  # nullify tests
  test 'region nullifies the country_id when a country gets deleted' do
    countries(:sweden).destroy
    assert_nil regions(:east_sweden).country_id
  end

  test 'city nullifies the country_id when a country gets deleted' do
    countries(:sweden).destroy
    assert_nil cities(:stockholm).country_id
  end

  # validation tests for presence
  test 'presence validations for the name of a country' do
    countries(:turkey).name = nil
    refute countries(:turkey).valid?
    assert_not_nil countries(:turkey).errors[:name]
  end

  test 'presence validations for the iso of a country' do
    countries(:turkey).iso = nil
    refute countries(:turkey).valid?
    assert_not_nil countries(:turkey).errors[:iso]
  end

  test 'presence validations for the code of a country' do
    countries(:turkey).code = nil
    refute countries(:turkey).valid?
    assert_not_nil countries(:turkey).errors[:code]
  end

  # validation tests for uniqueness
  test 'uniqueness validations for countries' do
    fake = countries(:turkey).dup
    refute fake.valid?
  end

  test 'uniqueness validations for name field of a country' do
    fake = countries(:turkey).dup
    assert_not_nil fake.errors[:name]
  end

  test 'uniqueness validations for iso field of a country' do
    fake = countries(:turkey).dup
    assert_not_nil fake.errors[:iso]
  end

  test 'uniqueness validations for code field of a country' do
    fake = countries(:turkey).dup
    assert_not_nil fake.errors[:code]
  end

  # callback tests
  test 'callbacks must titlecase the name and must upcase the iso codes for a country' do
    country = Country.create(name: 'wonderland of alice', iso: 'wl1', code: 1)
    assert_equal country.name, 'Wonderland Of Alice'
    assert_equal country.iso, 'WL1'
  end
end
