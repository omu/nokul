# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper

  # relations
  has_many :courses, dependent: :nullify
  has_many :prospective_students, dependent: :nullify

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
  before_validation :capitalize_attributes
end
