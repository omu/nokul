# frozen_string_literal: true

class CommitteeDecision < ApplicationRecord
  # callbacks
  before_validation :assign_year_and_decision_no, on: :create
  after_create :change_status_to_decided

  # relations
  belongs_to :meeting_agenda
  has_one :agenda, through: :meeting_agenda
  has_many :calendar_committee_decisions, dependent: :destroy

  # validations
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :decision_no, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :year, numericality: {
    only_inter:               true,
    greater_than_or_equal_to: 1950,
    less_than_or_equal_to:    2050
  }

  # delegates
  delegate :meeting_no, :meeting_date, :year, :unit, to: :meeting_agenda, prefix: true

  def count_of_decisions_by_year(year)
    meeting_agenda_unit.decisions.where(year: year).count
  end

  private

  def assign_year_and_decision_no
    self.year = meeting_agenda_year
    self.decision_no = "#{year}/#{count_of_decisions_by_year(year) + 1}"
  end

  def change_status_to_decided
    agenda.update(status: :decided)
  end
end
