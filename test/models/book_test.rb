# frozen_string_literal: true

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # enums
  enum activity: { passive: 0, active: 1 }
  enum contribution_rate: { all_of: 0, chapters: 1 }
  enum scope: { national: 0, international: 1 }
  enum type: {
    scientific:           25,
    textbook:             26,
    encyclopedia_article: 28,
    translation:          29,
    research:             43
  }
  enum type_of_release: { printed: 1, electronic: 2, printed_and_electronic: 3 }

  # validations: presence
  validates_presence_of :activity
  validates_presence_of :scope
  validates_presence_of :yoksis_id

  # validations: length
  validates_length_of :access_link, maximum: 2000
  validates_length_of :authors
  validates_length_of :chapter_name
  validates_length_of :city
  validates_length_of :discipline
  validates_length_of :editor_name
  validates_length_of :isbn
  validates_length_of :keywords, maximum: 4000
  validates_length_of :language_of_publication
  validates_length_of :name
  validates_length_of :publisher

  # validations: numericality
  validates_numericality_of :author_id
  validates_numericality_of :chapter_first_page
  validates_numericality_of :chapter_last_page
  validates_numericality_of :number_of_authors
  validates_numericality_of :number_of_copy
  validates_numericality_of :number_of_page
  validates_numericality_of :year
  validates_numericality_of :yoksis_id
  validates_numerical_range :author_id, greater_than_or_equal_to: 0
  validates_numerical_range :chapter_first_page, greater_than_or_equal_to: 0
  validates_numerical_range :chapter_last_page, greater_than_or_equal_to: 0
  validates_numerical_range :incentive_point, greater_than_or_equal_to: 0
  validates_numerical_range :number_of_authors, greater_than_or_equal_to: 0
  validates_numerical_range :number_of_copy, greater_than_or_equal_to: 0
  validates_numerical_range :number_of_page, greater_than_or_equal_to: 0
  validates_numerical_range :year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :yoksis_id, greater_than_or_equal_to: 0
end
