# frozen_string_literal: true

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  # relational tests
  test 'a city can communicate with a country' do
    assert cities(:samsun).country
  end

  test 'a city can communicate with a region' do
    assert cities(:samsun).region
  end

  test 'a city can communicate with a unit' do
    assert cities(:samsun).units
  end

  # nullify tests
  test 'unit nullifies the city_id when a city gets deleted' do
    cities(:samsun).destroy
    assert_nil units(:omu).city_id
  end

  # validation tests for presence
  test 'presence validations for the name of a city' do
    cities(:samsun).name = nil
    refute cities(:samsun).valid?
    assert_not_nil cities(:samsun).errors[:name]
  end

  test 'presence validations for the iso of a city' do
    cities(:samsun).iso = nil
    refute cities(:samsun).valid?
    assert_not_nil cities(:samsun).errors[:iso]
  end

  test 'presence validations for the nuts_code of a city' do
    cities(:samsun).nuts_code = nil
    refute cities(:samsun).valid?
    assert_not_nil cities(:samsun).errors[:nuts_code]
  end

  # validation tests for uniqueness
  test 'uniqueness validations for cities' do
    fake = cities(:samsun).dup
    refute fake.valid?
  end

  test 'uniqueness validations for name field of a city' do
    fake = cities(:samsun).dup
    assert_not_nil fake.errors[:name]
  end

  test 'uniqueness validations for iso field of a city' do
    fake = cities(:samsun).dup
    assert_not_nil fake.errors[:iso]
  end

  test 'uniqueness validations for nuts_code field of a city' do
    fake = cities(:samsun).dup
    assert_not_nil fake.errors[:nuts_code]
  end

  # callback tests
  test 'callbacks must titlecase the name and must upcase the nuts_code of a city' do
    city = City.create(
      name: 'wonderland',
      nuts_code: 'wl1',
      iso: 'wl11',
      country: countries(:turkey),
      region: regions(:bati_karadeniz)
    )
    assert_equal city.name, 'Wonderland'
    assert_equal city.nuts_code, 'WL1'
    assert_equal city.iso, 'WL11'
  end
end
