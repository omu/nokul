# frozen_string_literal: true

class CommitteeMeeting < ApplicationRecord
  # relations
  belongs_to :unit

  # validations
  validates :meeting_no, presence: true, uniqueness: { scope: :year }
  validates :meeting_date, presence: true
  validates :year, presence: true

  # callbacks
  after_initialize { self.year = meeting_date.year }
end
