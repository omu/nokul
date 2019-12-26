# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :user

  # enums
  enum scope: { national: 0, international: 1 }
  enum review: { reviewed: 0, unreviewed: 1 }
  enum access_type: { printed: 1, electronic: 2, printed_and_electronic: 3 }
  enum status: { deleted: 0, active: 1 }

  enum index: {
    ssci:                       5,
    sci_expanded:               6,
    ahci:                       7,
    field_indexes:              8,
    well_established_indexes:   9,
    sci:                        40,
    unindexed:                  42,
    turkish_index:              45,
    ebsco:                      46,
    index_islamicus:            47,
    index_medicus:              48,
    dental_index:               49,
    engineering_index:          50,
    compumath_index:            51,
    education_index:            52,
    australian_education_index: 53,
    british_education_index:    54,
    eric:                       55,
    esci:                       56,
    index_chemicus:             59,
    architectural_periodicals:  60,
    design_and_applied_art:     61,
    art_index:                  62,
    iconda:                     63,
    economics_abstracts:        64,
    education_full_text:        65
  }

  enum type: {
    original_article:     1,
    technical_note:       2,
    commentary:           3,
    case_report:          4,
    letter_to_the_editor: 5,
    abstract:             6,
    book_review:          7,
    research_note:        8,
    expert_report:        9,
    review_article:       10,
    short_article:        11
  }

  # validations: presence
  validates_presence_of :authors
  validates_presence_of :title
  validates_presence_of :yoksis_id

  # validations: length
  validates_length_of :access_link, maximum: 65_535
  validates_length_of :authors, maximum: 65_535
  validates_length_of :city
  validates_length_of :discipline, maximum: 65_535
  validates_length_of :doi
  validates_length_of :issn
  validates_length_of :issue
  validates_length_of :journal
  validates_length_of :keyword
  validates_length_of :language_of_publication
  validates_length_of :special_issue_name
  validates_length_of :sponsored_by
  validates_length_of :title, maximum: 65_535
  validates_length_of :volume

  # validations: numericality
  validates_numericality_of :author_id
  validates_numericality_of :country
  validates_numericality_of :first_page
  validates_numericality_of :incentive_point
  validates_numericality_of :last_page
  validates_numericality_of :month
  validates_numericality_of :number_of_authors
  validates_numericality_of :special_issue
  validates_numericality_of :year
  validates_numericality_of :yoksis_id
  validates_numerical_range :author_id, greater_than: 0
  validates_numerical_range :country, greater_than: 0
  validates_numerical_range :first_page, greater_than: 0, less_than_or_equal_to: 15_000
  validates_numerical_range :incentive_point, greater_than_or_equal_to: 0
  validates_numerical_range :last_page, greater_than: 0, less_than_or_equal_to: 15_000
  validates_numerical_range :month, greater_than: 0, less_than_or_equal_to: 12
  validates_numerical_range :number_of_authors, greater_than: 0
  validates_numerical_range :special_issue, greater_than_or_equal_to: 0
  validates_numerical_range :year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  validates_numerical_range :yoksis_id, greater_than: 0

  test 'unique_count method' do
    assert_equal Article.unique_count, Article.active.group_by(&:yoksis_id).count
  end

  test 'most_recent method' do
    assert_equal Article.most_recent, Article.order(created_at: :desc).limit(10)
  end
end
