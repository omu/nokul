# frozen_string_literal: true

require 'test_helper'

class EducationInformationTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # enums
  enum activity: { deleted: 0, active: 1 }
  enum location: { domestic: 0, abroad: 1 }

  # validations: presence
  validates_presence_of :location
  validates_presence_of :program
  validates_presence_of :start_year
  validates_presence_of :yoksis_id

  # validations: length
  validates_length_of :advisor
  validates_length_of :advisor_id_number, is: 11
  validates_length_of :department
  validates_length_of :diploma_equivalency
  validates_length_of :diploma_no, maximum: 100
  validates_length_of :discipline
  validates_length_of :faculty
  validates_length_of :other_discipline
  validates_length_of :other_university
  validates_length_of :program
  validates_length_of :thesis_name
  validates_length_of :thesis_step, maximum: 100
  validates_length_of :university

  # validations: numericality
  validates_numericality_of :advisor_id_number
  validates_numericality_of :end_date_of_thesis
  validates_numericality_of :end_year
  validates_numericality_of :start_date_of_thesis
  validates_numericality_of :start_year
  validates_numericality_of :unit_id
  validates_numericality_of :yoksis_id
  validates_numerical_range :end_date_of_thesis, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :end_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :start_date_of_thesis, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :start_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :unit_id, greater_than: 0
  validates_numerical_range :yoksis_id, greater_than: 0
end
