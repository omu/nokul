# frozen_string_literal: true

require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  # relations
  %i[
    country
    cities
    districts
    addresses
    units
  ].each do |property|
    test "a region can communicate with #{property}" do
      assert regions(:bati_karadeniz).send(property)
    end
  end

  # validations: presence
  %i[
    name
    nuts_code
  ].each do |property|
    test "presence validations for #{property} of a region" do
      regions(:bati_karadeniz).send("#{property}=", nil)
      assert_not regions(:bati_karadeniz).valid?
      assert_not_empty regions(:bati_karadeniz).errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    nuts_code
  ].each do |property|
    test "uniqueness validations for #{property} of a region" do
      fake = regions(:bati_karadeniz).dup
      assert_not fake.valid?
      assert_not_empty fake.errors[property]
    end
  end

  # callbacks
  test 'callbacks must titlecase the name and must upcase the nuts_code of a region' do
    region = Region.create(name: 'wonderland of alice', nuts_code: 'wl1', country: countries(:turkey))
    assert_equal region.name, 'Wonderland Of Alice'
    assert_equal region.nuts_code, 'WL1'
  end
end
