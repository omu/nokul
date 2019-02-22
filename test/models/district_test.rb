# frozen_string_literal: true

require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :city
  has_many :addresses, dependent: :nullify
  has_many :units, dependent: :nullify

  # validations: presence
  validates_presence_of :name
  validates_presence_of :active

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :mernis_code

  # validations: length
  validates_length_of :name
  validates_length_of :mernis_code, is: 4

  # validations: numericality
  validates_numericality_of :mernis_code

  # callbacks
  before_validation :capitalize_attributes
end
