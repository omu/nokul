# frozen_string_literal: true

class MeetingAgenda < ApplicationRecord
  # relations
  belongs_to :agenda
  belongs_to :committee_meeting

  # validations
  validates :sequence_no, presence: true, uniqueness: { scope: %i[committee_meeting] },
                          numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :agenda_id, presence: true, uniqueness: { scope: :committee_meeting }
end
