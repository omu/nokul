# frozen_string_literal: true

class Certification < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :user

  # validations
  validates :yoksis_id, presence: true, uniqueness: { scope: %i[user_id status] },
                        numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :type, presence: true, inclusion: { in: self.types.keys }
  validates :name, allow_blank: true, length: { maximum: 255 }
  validates :content, allow_blank: true, length: { maximum: 65535 }
  validates :location, allow_blank: true, length: { maximum: 255 }
  validates :scope, allow_blank: true, inclusion: { in: self.scopes.keys }
  validates :duration, allow_blank: true, length: { maximum: 255 }
  validates :number_of_authors, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :city_and_country, allow_blank: true, length: { maximum: 255 }
  validates :status, allow_blank: true, inclusion: { in: self.statuses.keys }

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
end
