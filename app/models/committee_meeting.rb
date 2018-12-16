# frozen_string_literal: true

class CommitteeMeeting < ApplicationRecord
  # relations
  belongs_to :unit
  has_many :meeting_agendas, dependent: :destroy
  has_many :agendas, through: :meeting_agendas
  has_many :decisions, through: :meeting_agendas, class_name: 'CommitteeDecision'
  accepts_nested_attributes_for :meeting_agendas, allow_destroy: true

  # validations
  validates :meeting_no, uniqueness: { scope: %i[unit year] },
                         numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :meeting_date, presence: true
  validates :year, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1950,
    less_than_or_equal_to: 2050
  }

  # callbacks
  before_validation { self.year = meeting_date.try(:year) }
end
