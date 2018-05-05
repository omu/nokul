# frozen_string_literal: true

require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  # relational tests
  test 'a region can communicate with a country' do
    assert regions(:bati_karadeniz).country
  end

  test 'a region can communicate with cities' do
    assert regions(:bati_karadeniz).cities
  end

  test 'a region can communicate with districts' do
    assert regions(:bati_karadeniz).districts
  end

  test 'a region can communicate with units' do
    assert regions(:bati_karadeniz).units
  end

  # nullify tests
  test 'city nullifies the region_id when a region gets deleted' do
    regions(:east_sweden).destroy
    assert_nil cities(:stockholm).region_id
  end

  # validation tests for presence
  test 'presence validations for the name of a region' do
    regions(:bati_karadeniz).name = nil
    refute regions(:bati_karadeniz).valid?
    assert_not_nil regions(:bati_karadeniz).errors[:name]
  end

  test 'presence validations for the nuts_code of a region' do
    regions(:bati_karadeniz).nuts_code = nil
    refute regions(:bati_karadeniz).valid?
    assert_not_nil regions(:bati_karadeniz).errors[:nuts_code]
  end

  # validation tests for uniqueness
  test 'uniqueness validations for regions' do
    fake = regions(:bati_karadeniz).dup
    refute fake.valid?
  end

  test 'uniqueness validations for name field of a region' do
    fake = regions(:bati_karadeniz).dup
    assert_not_nil fake.errors[:name]
  end

  test 'uniqueness validations for nuts_code field of a region' do
    fake = regions(:bati_karadeniz).dup
    assert_not_nil fake.errors[:nuts_code]
  end

  # callback tests
  test 'callbacks must titlecase the name and must upcase the nuts_code of a region' do
    region = Region.create(name: 'wonderland of alice', nuts_code: 'wl1', country: countries(:turkey))
    assert_equal region.name, 'Wonderland Of Alice'
    assert_equal region.nuts_code, 'WL1'
  end
end
