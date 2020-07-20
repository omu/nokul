# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  has_many :addresses, through: :districts
  has_many :cities, dependent: :destroy
  has_many :districts, through: :cities
  has_many :units, through: :districts

  # validations: presence
  validates_presence_of :name
  validates_presence_of :alpha_2_code
  validates_presence_of :alpha_3_code
  validates_presence_of :continent
  validates_presence_of :currency_code
  validates_presence_of :numeric_code
  validates_presence_of :sms_delivery_report
  validates_presence_of :sms_alpha_sender_id
  validates_presence_of :sms_unicode
  validates_presence_of :sms_concatenation
  validates_presence_of :world_region

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :alpha_2_code
  validates_uniqueness_of :alpha_3_code
  validates_uniqueness_of :mernis_code
  validates_uniqueness_of :numeric_code

  # validations: length
  validates_length_of :name
  validates_length_of :alpha_2_code, is: 2
  validates_length_of :alpha_3_code, is: 3
  validates_length_of :continent, maximum: 255
  validates_length_of :currency_code, is: 3
  validates_length_of :mernis_code, is: 4
  validates_length_of :numeric_code, is: 3
  validates_length_of :phone_code, maximum: 3
  validates_length_of :region, maximum: 255
  validates_length_of :start_of_week, maximum: 255
  validates_length_of :subregion, maximum: 255
  validates_length_of :un_locode, is: 2
  validates_length_of :world_region, maximum: 255

  # validations: numericality
  validates_numericality_of :latitude
  validates_numericality_of :longitude
  validates_numericality_of :numeric_code
  validates_numericality_of :yoksis_code
  validates_numerical_range :yoksis_code, greater_than_or_equal_to: 1

  # callbacks
  before_validation :capitalize_attributes
end
