# frozen_string_literal: true

class Student < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy
  has_many :academic_calendars, -> { AcademicCalendar.active }, through: :unit

  # validations
  validates :unit_id, uniqueness: { scope: %i[user] }
  validates :student_number, presence: true, uniqueness: true

  # delegations
  delegate :addresses, to: :user

  # background jobs
  after_create_commit :build_identity_information, if: proc { identity.nil? }

  def build_identity_information
    Kps::IdentitySaveJob.perform_later(user, id)
  end

  def proper_event_range?(title)
    event =
      academic_calendars.last.calendar_events
                        .find_by(calendar_title: CalendarTitle.find_by(identifier: title))
    return event.proper_range? if event

    false
  end
end
