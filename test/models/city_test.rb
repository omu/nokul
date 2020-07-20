# frozen_string_literal: true

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::CallbackHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :country
  has_many :addresses, through: :districts
  has_many :districts, dependent: :destroy
  has_many :units, through: :districts

  # validations: presence
  validates_presence_of :name
  validates_presence_of :alpha_2_code

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :alpha_2_code

  # validations: length
  validates_length_of :name
  validates_length_of :alpha_2_code

  # validations: numericality
  validates_numericality_of :latitude
  validates_numericality_of :longitude

  # callbacks
  before_validation :capitalize_attributes
end
