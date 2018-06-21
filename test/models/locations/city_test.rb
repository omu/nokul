# frozen_string_literal: true

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  # relations
  %i[
    districts
    addresses
    units
  ].each do |property|
    test "a city can communicate with #{property}" do
      assert cities(:samsun).send(property)
    end
  end

  # validations: presence
  %i[
    name
    iso
    nuts_code
  ].each do |property|
    test "presence validations for #{property} of a city" do
      cities(:samsun).send("#{property}=", nil)
      assert_not cities(:samsun).valid?
      assert_not_empty cities(:samsun).errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    iso
    nuts_code
  ].each do |property|
    test "uniqueness validations for #{property} of a city" do
      fake = cities(:samsun).dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name and must upcase the nuts_code of a city' do
    city = City.create(
      name: 'wonderland',
      nuts_code: 'wl1',
      iso: 'wl11',
      country: countries(:turkey)
    )
    assert_equal city.name, 'Wonderland'
    assert_equal city.nuts_code, 'WL1'
    assert_equal city.iso, 'WL11'
  end
end
