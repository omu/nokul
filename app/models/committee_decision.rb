# frozen_string_literal: true

class CommitteeDecision < ApplicationRecord
  # relations
  belongs_to :meeting_agenda

  # validations
  validates :description, presence: true
  validates :decision_no, presence: true, uniqueness: true
end
