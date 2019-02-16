# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule

  # relations
  has_many :addresses
  has_many :cities
  has_many :districts
  has_many :units

  # validations: presence
  validates_presence_of :name
  validates_presence_of :alpha_2_code
  validates_presence_of :alpha_3_code
  validates_presence_of :numeric_code

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :alpha_2_code
  validates_uniqueness_of :alpha_3_code
  validates_uniqueness_of :numeric_code
  validates_uniqueness_of :mernis_code

  # validations: length
  validates_length_of :name

  # validations: numericality
  validates_numericality_of(:yoksis_code)
  validates_numerical_range(:yoksis_code, :greater_than_or_equal_to, 1)

  # callbacks
  has_validation_callback :capitalize_attributes, :before

  # other validations
  test 'alpha_2_code must be 2 characters' do
    fake = countries(:turkey).dup
    fake.alpha_2_code = (0...3).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:alpha_2_code].map { |err| err[:error] }.include?(:wrong_length)
  end

  test 'alpha_3_code must be 3 characters' do
    fake = countries(:turkey).dup
    fake.alpha_3_code = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?
    assert fake.errors.details[:alpha_3_code].map { |err| err[:error] }.include?(:wrong_length)
  end

  test 'numeric_code must be an integer with 3 digits' do
    fake = countries(:turkey).dup
    fake.numeric_code = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?

    error_codes = fake.errors.details[:numeric_code].map { |err| err[:error] }
    assert error_codes.include?(:wrong_length)
    assert error_codes.include?(:not_a_number)
  end

  test 'mernis_code must be an integer with 4 digits' do
    fake = countries(:turkey).dup
    fake.mernis_code = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?

    error_codes = fake.errors.details[:mernis_code].map { |err| err[:error] }
    assert error_codes.include?(:wrong_length)
    assert error_codes.include?(:not_a_number)
  end
end
