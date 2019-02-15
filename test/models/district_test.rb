# frozen_string_literal: true

require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  
  # relations
  belongs_to :city
  has_many :units
  has_many :addresses

  # validations: presence
  validates_presence_of :name
  validates_presence_of :city

  # validations: uniqueness
  test 'uniqueness validations for name field of a district, scoped with city' do
    fake = districts(:vezirkopru).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]
    assert_not_empty fake.errors[:mernis_code]
  end

  # callbacks
  test 'callbacks must titlecase the name of a district' do
    district = District.create!(name: 'wonderland of samsun', city: cities(:samsun), active: true)
    assert_equal district.name, 'Wonderland Of Samsun'
  end

  # other validations
  test 'name can not be longer than 255 characters' do
    fake = districts(:vezirkopru).dup
    fake.name = (0...256).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:name].map { |err| err[:error] }.include?(:too_long)
  end

  test 'mernis_code must be an integer with 4 digits' do
    fake = districts(:vezirkopru).dup
    fake.mernis_code = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?

    error_codes = fake.errors.details[:mernis_code].map { |err| err[:error] }
    assert error_codes.include?(:wrong_length)
    assert error_codes.include?(:not_a_number)
  end

  test 'active field of district can not be nil' do
    fake = districts(:vezirkopru).dup
    fake.active = nil
    assert_not fake.valid?

    error_codes = fake.errors.details[:active].map { |err| err[:error] }
    assert error_codes.include?(:inclusion)
  end
end
