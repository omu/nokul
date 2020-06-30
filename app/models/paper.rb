# frozen_string_literal: true

class Paper < ApplicationRecord
  self.inheritance_column = nil

  # enums
  enum activity: { passive: 0, active: 1 }
  enum presentation_type: { verbal: 33, guest_speaker: 39, poster: 38 }
  enum publication_status: { unpublished: 0, published: 1, accepted: 2 }
  enum scope: { national: 0, international: 1 }
  enum type: { full_text: 36, summary: 37 }
  enum type_of_release: { printed: 1, electronic: 2, printed_and_electronic: 3 }

  # relations
  belongs_to :user, counter_cache: true
  belongs_to :country, optional: true

  # validations
  validates :access_link, length: { maximum: 2000 }
  validates :activity, inclusion: { in: activities.keys }
  validates :author_id, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :authors, length: { maximum: 255 }
  validates :number_of_authors, numericality: { only_integer: true, greater_than: 0, allow_nil: true }
  validates :city, length: { maximum: 255 }
  validates :discipline, length: { maximum: 255 }
  validates :doi, length: { maximum: 255 }
  validates :issn, length: { maximum: 255 }
  validates :incentive_point, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :issue, length: { maximum: 255 }
  validates :keywords, length: { maximum: 4000 }
  validates :language_of_publication, length: { maximum: 255 }
  validates :first_page, allow_nil:    true,
                         numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 15_000 }
  validates :last_page, allow_nil:    true,
                        numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 15_000 }
  validates :name, length: { maximum: 255 }
  validates :presentation_type, allow_nil: true, inclusion: { in: presentation_types.keys }
  validates :print_isbn, length: { maximum: 255 }
  validates :publication_status, allow_nil: true, inclusion: { in: publication_statuses.keys }
  validates :scope, inclusion: { in: scopes.keys }
  validates :special_issue, length: { maximum: 255 }
  validates :sponsored_by, length: { maximum: 255 }
  validates :type, allow_nil: true, inclusion: { in: types.keys }
  validates :type_of_release, allow_nil: true, inclusion: { in: type_of_releases.keys }
  validates :volume, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :yoksis_id, uniqueness: { scope: :user }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
