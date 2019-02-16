# frozen_string_literal: true

require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule

  # relations
  belongs_to :city
  has_many :addresses
  has_many :units

  # validations: presence
  validates_presence_of :name
  validates_presence_of :active

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :mernis_code

  # validations: length
  validates_length_of :name

  # callbacks
  has_validation_callback :capitalize_attributes, :before

  test 'mernis_code must be an integer with 4 digits' do
    fake = districts(:vezirkopru).dup
    fake.mernis_code = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not fake.valid?

    error_codes = fake.errors.details[:mernis_code].map { |err| err[:error] }
    assert error_codes.include?(:wrong_length)
    assert error_codes.include?(:not_a_number)
  end
end
