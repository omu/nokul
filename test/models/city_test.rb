# frozen_string_literal: true

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule

  # relations
  belongs_to :country
  has_many :addresses
  has_many :districts
  has_many :units

  # validations: presence
  validates_presence_of :name
  validates_presence_of :alpha_2_code

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :alpha_2_code

  # validations: length
  validates_length_of :name
  validates_length_of :alpha_2_code

  # callbacks
  has_validation_callback :capitalize_attributes, :before
end
