# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  include EnumForTerm

  # relations
  has_many :calendars, dependent: :nullify
  has_many :registration_documents, dependent: :nullify

  # callbacks

  after_save -> { AcademicTerm.where.not(id: id).update_all(active: false) }, if: :active?

  # validations
  validates :year, presence: true, uniqueness: { scope: :term }, length: { maximum: 255 }
  validates :start_of_term, presence: true
  validates :end_of_term, presence: true
  validates :active, inclusion: { in: [true, false] }
  validates_with AcademicTermValidator

  # scopes
  scope :active, -> { where(active: true) }
end
