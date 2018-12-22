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
    alpha_2_code
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
    alpha_2_code
  ].each do |property|
    test "uniqueness validations for #{property} of a city" do
      fake = cities(:samsun).dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name and must upcase the alpha_2_code of a city' do
    city = City.create(
      name: 'wonderland',
      alpha_2_code: 'wl-11',
      country: countries(:turkey)
    )
    assert_equal city.name, 'Wonderland'
    assert_equal city.alpha_2_code, 'WL-11'
  end

  # other validations
  test 'name can not be longer than 255 characters' do
    fake = cities(:samsun).dup
    fake.name = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
  end

  test 'alpha_2_code can not be longer than 255 characters' do
    fake = cities(:samsun).dup
    fake.alpha_2_code = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:alpha_2_code].map { |err| err[:error] }.include?(:too_long)
  end
end
