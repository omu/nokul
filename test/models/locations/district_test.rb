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
  end

  # callbacks
  test 'callbacks must titlecase the name of a district' do
    district = District.create(name: 'wonderland of samsun', city: cities(:samsun))
    assert_equal district.name, 'Wonderland Of Samsun'
    assert_equal 'foo'.capitalize_all, 'Foo'
  end
end
