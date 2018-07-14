# frozen_string_literal: true

class Certification < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :user

  # validations
  validates :yoksis_id, presence: true, uniqueness: { scope: %i[user_id status] }
  validates :title, presence: true
  validates :type, presence: true

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
