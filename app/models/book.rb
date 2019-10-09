# frozen_string_literal: true

class Book < ApplicationRecord
  self.inheritance_column = nil

  # enums
  enum activity: { deleted: 0, active: 1 }
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

  # relations
  belongs_to :user, counter_cache: true
  belongs_to :country, optional: true

  # validations
  validates :access_link, length: { maximum: 2000 }
  validates :activity, inclusion: { in: activities.keys }
  validates :author_id, numericality: { only_integer: true, greater_than: 0, allow_nil: true }
  validates :authors, length: { maximum: 255 }
  validates :chapter_first_page, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :chapter_last_page, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :chapter_name, length: { maximum: 255 }
  validates :city, length: { maximum: 255 }
  validates :contribution_rate, allow_nil: true, inclusion: { in: contribution_rates.keys }
  validates :discipline, length: { maximum: 255 }
  validates :editor_name, length: { maximum: 255 }
  validates :incentive_point, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :isbn, length: { maximum: 255 }
  validates :keywords, length: { maximum: 4000 }
  validates :language_of_publication, length: { maximum: 255 }
  validates :name, length: { maximum: 255 }
  validates :number_of_authors, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :number_of_copy, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :number_of_page, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :publisher, length: { maximum: 255 }
  validates :scope, inclusion: { in: scopes.keys }
  validates :type, allow_nil: true, inclusion: { in: types.keys }
  validates :type_of_release, allow_nil: true, inclusion: { in: type_of_releases.keys }
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050 }
  validates :yoksis_id, uniqueness: { scope: :user }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
