# frozen_string_literal: true

class AcademicCalendar < ApplicationRecord
  # relations
  belongs_to :academic_term
  belongs_to :calendar_type
  has_many :calendar_events, dependent: :destroy
  has_many :unit_calendar_events, dependent: :destroy
  accepts_nested_attributes_for :calendar_events, allow_destroy: true

  # validations
  validates :name, presence: true
  validates :senate_decision_date, presence: true
  validates :senate_decision_no, presence: true
  validates :academic_term, uniqueness: { scope: :calendar_type }

  # callbacks
  around_save :catch_uniqueness_exception

  # delegates
  delegate :name, to: :calendar_type, prefix: :type

  private

  def catch_uniqueness_exception
    yield
  rescue ActiveRecord::RecordNotUnique
    errors.add(:calendar_event, 'event is already taken')
  end
end
