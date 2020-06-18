# frozen_string_literal: true

require 'test_helper'

class CertificationTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :user

  # enums
  enum type: {
    certification:       1,
    course:              2,
    research:            3,
    study:               4,
    report:              5,
    workshop:            6,
    interview:           7,
    essay:               8,
    evaluation:          9,
    conversation:        10,
    translation:         11,
    seminar:             12,
    speeches:            13,
    organizing_congress: 14
  }
  enum scope: { national: 0, international: 1 }
  enum status: { active: 1, passive: 2 }

  # validations: presence
  validates_presence_of :title
  validates_presence_of :yoksis_id

  # validations: length
  validates_length_of :title
  validates_length_of :name
  validates_length_of :content, maximum: 65_535
  validates_length_of :location
  validates_length_of :duration
  validates_length_of :city_and_country

  # validations: numericality
  validates_numericality_of :number_of_authors
  validates_numericality_of :yoksis_id
  validates_numerical_range :number_of_authors, greater_than: 0
  validates_numerical_range :yoksis_id, greater_than: 0
end
