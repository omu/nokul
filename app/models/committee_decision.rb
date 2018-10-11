# frozen_string_literal: true

class CommitteeDecision < ApplicationRecord
  # relations
  belongs_to :meeting_agenda

  # validations
  validates :description, presence: true
  validates :decision_no, presence: true, uniqueness: true
  validates :year, presence: true

  # callbacks
  before_validation :set_year_and_decision_no, on: :create

  # delegates
  delegate :meeting_no, :meeting_date, :year, :unit, to: :meeting_agenda, prefix: true

  def count_of_decisions_by_year(year)
    meeting_agenda_unit.decisions.where(year: year).count
  end

  private

  def set_year_and_decision_no
    self.year = meeting_agenda_year
    self.decision_no = "#{year}/#{count_of_decisions_by_year(year) + 1}"
  end
end
