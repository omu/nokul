# frozen_string_literal: true

class CalendarCommitteeDecision < ApplicationRecord
  # relations
  belongs_to :calendar
  belongs_to :committee_decision

  # validations
  validates :calendar, uniqueness: { scope: :committee_decision }
end
