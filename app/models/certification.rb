# frozen_string_literal: true

class Certification < ApplicationRecord
  self.inheritance_column = nil

  # enums
  enum type: {
    certification: 1,
    course: 2,
    research: 3,
    study: 4,
    report: 5,
    workshop: 6,
    interview: 7,
    essay: 8,
    evaluation: 9,
    conversation: 10,
    translation: 11
  }

  enum scope: { national: 0, international: 1 }
  enum status: { active: 1, passive: 2 }

  # relations
  belongs_to :user

  # validations
  validates :yoksis_id, presence: true, uniqueness: { scope: %i[user_id status] },
                        numericality: { only_integer: true, greater_than: 0 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :type, presence: true, inclusion: { in: types.keys }
  validates :name, allow_nil: true, length: { maximum: 255 }
  validates :content, allow_nil: true, length: { maximum: 65_535 }
  validates :location, allow_nil: true, length: { maximum: 255 }
  validates :scope, allow_nil: true, inclusion: { in: scopes.keys }
  validates :duration, allow_nil: true, length: { maximum: 255 }
  validates :number_of_authors, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :city_and_country, allow_nil: true, length: { maximum: 255 }
  validates :status, allow_nil: true, inclusion: { in: statuses.keys }
end
