# frozen_string_literal: true

class Agenda < ApplicationRecord
  # search
  include PgSearch
  include DynamicSearch

  pg_search_scope(
    :search,
    against: %i[description],
    using: { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :status, :agenda_type_id

  # enums
  enum status: { recent: 0, decided: 1, delayed: 2 }

  # relations
  has_one_attached :agenda_file
  belongs_to :unit
  belongs_to :agenda_type
  has_many :meeting_agendas, dependent: :destroy
  has_many :meetings, through: :meeting_agendas, source: :committee_meeting

  # validations
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :status, inclusion: { in: statuses.keys }

  # scopes
  scope :active, -> { where(status: %i[recent delayed]) }
end
