# frozen_string_literal: true

class MeetingAgenda < ApplicationRecord
  # relations
  belongs_to :agenda
  belongs_to :committee_meeting
  has_one :decision, dependent: :destroy, class_name: 'CommitteeDecision'

  # validations
  validates :sequence_no, uniqueness: { scope: %i[committee_meeting] },
                          numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :agenda_id, uniqueness: { scope: :committee_meeting }

  # delegates
  delegate :description, :status, :agenda_type, to: :agenda
  delegate :meeting_no, :meeting_date, :year, :unit, to: :committee_meeting
end
