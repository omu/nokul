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
  validates_length_of :alpha_2_code, is: 2
  validates_length_of :alpha_3_code, is: 3
  validates_length_of :numeric_code, is: 3
  validates_length_of :mernis_code, is: 4

  # validations: numericality
  validates_numericality_of :numeric_code
  validates_numericality_of :yoksis_code
  validates_numerical_range :yoksis_code, greater_than_or_equal_to: 1

  # callbacks
  has_validation_callback :capitalize_attributes, :before
end
