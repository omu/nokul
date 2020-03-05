# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  include EnumForTerm

  # callbacks
  after_save :deactivate_academic_terms, :delete_cache

  # relations
  has_many :calendars, dependent: :nullify
  has_many :prospective_students, dependent: :nullify
  has_many :registration_documents, dependent: :nullify
  has_many :semester_registrations, dependent: :nullify
  has_many :tuitions, dependent: :nullify

  # validations
  validates :active, inclusion: { in: [true, false] }
  validates :end_of_term, presence: true
  validates :start_of_term, presence: true
  validates :year, presence: true, uniqueness: { scope: :term }, length: { maximum: 255 }
  validates_with AcademicTermValidator

  # scopes
  scope :active, -> { where(active: true) }

  def self.current
    Rails.cache.fetch('active_term') { active.last }
  end

  private

  def deactivate_academic_terms
    AcademicTerm.where.not(id: id).update(active: false) if active?
  end

  def delete_cache
    Rails.cache.delete('active_term')
  end
end
