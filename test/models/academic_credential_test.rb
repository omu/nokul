# frozen_string_literal: true

require 'test_helper'

class AcademicCredentialTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # enums
  enum activity: { deleted: 0, active: 1 }
  enum location: { domestic: 0, abroad: 1 }
  enum status: { full_time: 0, part_time: 1 }

  # validations: presence
  validates_presence_of :yoksis_id
  validates_presence_of :activity
  validates_presence_of :unit_id
  validates_presence_of :university_id
  validates_presence_of :university_name

  # validations: length
  validates_length_of :department
  validates_length_of :discipline
  validates_length_of :profession_name
  validates_length_of :scientific_field
  validates_length_of :title
  validates_length_of :unit_name
  validates_length_of :university_name

  # validations: numericality
  validates_numericality_of :yoksis_id
  validates_numerical_range :yoksis_id, greater_than: 0
  validates_numerical_range :start_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :end_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
end
