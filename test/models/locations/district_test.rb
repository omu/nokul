# frozen_string_literal: true

require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  # relational tests for the related models of district
  %i[
    city
    units
  ].each do |property|
    test "a district can communicate with #{property}" do
      assert districts(:atakum).send(property)
    end
  end

  # nullify tests
  test 'unit nullifies the district_id when a city gets deleted' do
    districts(:atakum).destroy
    assert_nil units(:cbu).district_id
  end

  # validation tests for the presence of listed properties
  %i[
    name
    city
  ].each do |property|
    test "presence validations for #{property} of a district" do
      districts(:vezirkopru).send("#{property}=", nil)
      refute districts(:vezirkopru).valid?
      refute_empty districts(:vezirkopru).errors[property]
    end
  end

  test 'uniqueness validations for name field of a district, scoped with city' do
    fake = districts(:vezirkopru).dup
    refute fake.valid?
    refute_empty fake.errors[:name]
  end

  # callback tests
  test 'callbacks must titlecase the name of a district' do
    district = District.create(name: 'wonderland of samsun', city: cities(:samsun))
    assert_equal district.name, 'Wonderland Of Samsun'
  end
end
