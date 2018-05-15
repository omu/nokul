# frozen_string_literal: true

class CalendarEvent < ApplicationRecord
  # relations
  belongs_to :academic_calendar
  belongs_to :calendar_title

  # validations
  validates :start_date, presence: true
  validates :academic_calendar, uniqueness: { scope: :calendar_title }

  # callbacks
  around_save :catch_uniqueness_exception

  private

  def catch_uniqueness_exception
    yield
  rescue ActiveRecord::RecordNotUnique
    errors.add(:calendar_event, 'event is already taken')
  end
end
