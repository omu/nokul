# frozen_string_literal: true

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  # relational tests for the related models of city
  %i[
    region
    districts
    units
  ].each do |property|
    test "a city can communicate with #{property}" do
      assert cities(:samsun).send(property)
    end
  end

  # nullify tests
  test 'district nullifies the city_id when a city gets deleted' do
    cities(:samsun).destroy
    assert_nil districts(:atakum).city_id
  end

  # validation tests for the presence of listed properties
  %i[
    name
    iso
    nuts_code
  ].each do |property|
    test "presence validations for #{property} of a city" do
      cities(:samsun).send("#{property}=", nil)
      refute cities(:samsun).valid?
      assert_not_nil cities(:samsun).errors[property]
    end
  end

  # validation tests for the uniqueness of listed properties
  %i[
    name
    iso
    nuts_code
  ].each do |property|
    test "uniqueness validations for #{property} of a city" do
      fake = cities(:samsun).dup
      refute fake.valid?
      assert_not_nil fake.errors[property]
    end
  end

  # callback tests
  test 'callbacks must titlecase the name and must upcase the nuts_code of a city' do
    city = City.create(
      name: 'wonderland',
      nuts_code: 'wl1',
      iso: 'wl11',
      region: regions(:bati_karadeniz)
    )
    assert_equal city.name, 'Wonderland'
    assert_equal city.nuts_code, 'WL1'
    assert_equal city.iso, 'WL11'
  end
end
