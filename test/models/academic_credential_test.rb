# frozen_string_literal: true

require 'test_helper'

class AcademicCredentialTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::EnumerationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # enums
  enum activity: { passive: 0, active: 1 }
  enum location: { domestic: 1, abroad: 2 }
  enum status: { full_time: 0, part_time: 1 }

  # validations: presence
  validates_presence_of :location
  validates_presence_of :start_year
  validates_presence_of :yoksis_id

  # validations: length
  validates_length_of :department
  validates_length_of :discipline
  validates_length_of :faculty
  validates_length_of :profession_name
  validates_length_of :scientific_field
  validates_length_of :title
  validates_length_of :university

  # validations: numericality
  validates_numericality_of :end_year
  validates_numericality_of :start_year
  validates_numericality_of :unit_id
  validates_numericality_of :yoksis_id
  validates_numerical_range :end_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :start_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :unit_id, greater_than: 0
  validates_numerical_range :yoksis_id, greater_than: 0
end
