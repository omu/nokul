# frozen_string_literal: true

require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  # relational tests
  test 'a district can communicate with a city' do
    assert districts(:vezirkopru).city
  end

  test 'a district can communicate with units' do
    assert districts(:atakum).units
  end

  # nullify tests
  test 'unit nullifies the district_id when a city gets deleted' do
    districts(:atakum).destroy
    assert_nil units(:cbu).district_id
  end

  # validation tests for presence
  test 'presence validations for the name of a district' do
    districts(:vezirkopru).name = nil
    refute districts(:vezirkopru).valid?
    assert_not_nil districts(:vezirkopru).errors[:name]
  end

  test 'presence validations for the city relation' do
    districts(:vezirkopru).city = nil
    refute districts(:vezirkopru).valid?
  end

  # validation tests for uniqueness
  test 'uniqueness validations for districts' do
    fake = districts(:vezirkopru).dup
    refute fake.valid?
  end

  test 'uniqueness validations for name field of a district, scoped with city' do
    fake = districts(:vezirkopru).dup
    assert_not_nil fake.errors[:name]
  end

  # callback tests
  test 'callbacks must titlecase the name of a district' do
    district = District.create(name: 'wonderland of samsun', city: cities(:samsun))
    assert_equal district.name, 'Wonderland Of Samsun'
  end
end
