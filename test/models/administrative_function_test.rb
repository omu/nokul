# frozen_string_literal: true

require 'test_helper'

class AdministrativeFunctionTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule

  # relations
  has_many :duties
  has_many :positions

  # validations: presence
  validates_presence_of :code
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :code
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # callbacks
  has_validation_callback :capitalize_attributes, :before
end
