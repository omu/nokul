# frozen_string_literal: true

require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  # relational tests for the related models of region
  %i[
    country
    cities
    districts
    units
  ].each do |property|
    test "a region can communicate with #{property}" do
      assert regions(:bati_karadeniz).send(property)
    end
  end

  # nullify tests
  test 'city nullifies the region_id when a region gets deleted' do
    regions(:east_sweden).destroy
    assert_nil cities(:stockholm).region_id
  end

  # validation tests for the presence of listed properties
  %i[
    name
    nuts_code
  ].each do |property|
    test "presence validations for #{property} of a region" do
      regions(:bati_karadeniz).send("#{property}=", nil)
      refute regions(:bati_karadeniz).valid?
      assert_not_nil regions(:bati_karadeniz).errors[property]
    end
  end

  # validation tests for the uniqueness of listed properties
  %i[
    name
    nuts_code
  ].each do |property|
    test "uniqueness validations for #{property} of a region" do
      fake = regions(:bati_karadeniz).dup
      refute fake.valid?
      assert_not_nil fake.errors[property]
    end
  end

  # callback tests
  test 'callbacks must titlecase the name and must upcase the nuts_code of a region' do
    region = Region.create(name: 'wonderland of alice', nuts_code: 'wl1', country: countries(:turkey))
    assert_equal region.name, 'Wonderland Of Alice'
    assert_equal region.nuts_code, 'WL1'
  end
end
