# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  include EnumForTerm

  # relations
  has_many :calendars, dependent: :nullify
  has_many :registration_documents, dependent: :nullify

  # validations
  validates :year, presence: true, uniqueness: { scope: :term }, length: { maximum: 255 }
  validates :start_of_term, presence: true
  validates :end_of_term, presence: true
  validates :active, inclusion: { in: [true, false] }

  # scopes
  scope :active, -> { where(active: true) }
end
