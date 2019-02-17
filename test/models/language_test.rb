# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include ValidationTestModule

  # relations
  has_many :courses
  has_many :prospective_students

  # validations: presence
  validates_presence_of :name
  validates_presence_of :iso

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :iso

  # validations: length
  validates_length_of :name
  validates_length_of :iso

  # callbacks
  has_validation_callback :capitalize_attributes, :before
end
