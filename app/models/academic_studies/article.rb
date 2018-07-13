# frozen_string_literal: true

class Article < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :user

  # validations
  validates :yoksis_id, presence: true
  validates :title, presence: true

  # enums
  enum scope: { national: 0, international: 1 }
  enum review: { reviewed: 0, not_reviewed: 1 }
  enum access_type: { printed: 1, electronic: 2, printed_and_electronic: 3 }
  enum status: { deleted: 0, active: 1 }

  enum index: {
    ssci: 5,
    sci_expanded: 6,
    ahci: 7,
    field_indexes: 8,
    well_established_indexes: 9,
    sci: 40,
    not_indexed: 42,
    ebsco: 46,
    index_islamicus: 47,
    index_medicus: 48,
    dental_index: 49,
    engineering_index: 50,
    compumath_index: 51,
    education_index: 52,
    australian_education_index: 53,
    british_education_index: 54,
    eric: 55,
    esci: 56,
    index_chemicus: 59,
    turkish_index: 45
  }

  enum type: {
    original_article: 1,
    technical_note: 2,
    commentary: 3,
    case_report: 4,
    letter_to_the_editor: 5,
    abstract: 6,
    book_review: 7,
    research_note: 8,
    export_report: 9,
    review_article: 10,
    short_article: 11
  }
end
