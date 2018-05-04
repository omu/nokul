# frozen_string_literal: true

class AcademicCalendar < ApplicationRecord
  # relations
  belongs_to :academic_term
  belongs_to :calendar_type
  has_many :calendar_events, dependent: :destroy
  has_many :unit_calendar_events, dependent: :destroy
  accepts_nested_attributes_for :calendar_events, reject_if: :reject_event, allow_destroy: true

  # validations
  validates :name, :senate_decision_date, :senate_decision_no, presence: true
  validates :academic_term_id, uniqueness: { scope: :calendar_type_id }

  def reject_event(attr)
    attr[:start_date].blank?
  end
end
