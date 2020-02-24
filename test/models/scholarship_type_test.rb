# frozen_string_literal: true

require 'test_helper'

class ScholarshipTypeTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  has_many :students, dependent: :nullify

  # validations: presence
  validates_presence_of :name
  validates_presence_of :active

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name
end
