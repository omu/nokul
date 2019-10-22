# frozen_string_literal: true

class Article < ApplicationRecord
  self.inheritance_column = nil

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

  # relations
  belongs_to :user, counter_cache: true

  # validations
  validates :yoksis_id, uniqueness: { scope: %i[user_id status] }, numericality: { only_integer: true, greater_than: 0 }
  validates :title, presence: true, length: { maximum: 65_535 }
  validates :authors, presence: true, length: { maximum: 65_535 }
  validates :city, length: { maximum: 255 }
  validates :journal, length: { maximum: 255 }
  validates :language_of_publication, length: { maximum: 255 }
  validates :volume, length: { maximum: 255 }
  validates :issue, length: { maximum: 255 }
  validates :doi, length: { maximum: 255 }
  validates :issn, length: { maximum: 255 }
  validates :access_link, length: { maximum: 65_535 }
  validates :discipline, length: { maximum: 65_535 }
  validates :keyword, length: { maximum: 255 }
  validates :sponsored_by, length: { maximum: 255 }
  validates :number_of_authors, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :type, allow_nil: true, inclusion: { in: types.keys }
  validates :scope, allow_nil: true, inclusion: { in: scopes.keys }
  validates :status, allow_nil: true, inclusion: { in: statuses.keys }
  validates :review, allow_nil: true, inclusion: { in: reviews.keys }
  validates :index, allow_nil: true, inclusion: { in: indices.keys }
  validates :country, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :month, allow_nil:    true,
                    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 12 }
  validates :year, allow_nil:    true,
                   numericality: { only_integer: true, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050 }
  validates :first_page, allow_nil:    true,
                         numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 15_000 }
  validates :last_page, allow_nil:    true,
                        numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 15_000 }
  validates :access_type, allow_nil: true, inclusion: { in: access_types.keys }
  validates :special_issue, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :special_issue_name, length: { maximum: 255 }
  validates :author_id, numericality: { only_integer: true, greater_than: 0, allow_nil: true }
  validates :incentive_point, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def self.unique_count
    active.group_by(&:yoksis_id).count
  end

  def self.most_recent
    order(created_at: :desc).limit(10)
  end
end
