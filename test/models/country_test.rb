# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper

  # relations
  has_many :addresses, through: :districts
  has_many :cities, dependent: :destroy
  has_many :districts, through: :cities
  has_many :units, through: :districts

  # validations: presence
  validates_presence_of :name
  validates_presence_of :alpha_2_code
  validates_presence_of :alpha_3_code
  validates_presence_of :numeric_code
  validates_presence_of :sms_delivery_report
  validates_presence_of :sms_alpha_sender_id
  validates_presence_of :sms_unicode
  validates_presence_of :sms_concatenation

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
  before_validation :capitalize_attributes
end
