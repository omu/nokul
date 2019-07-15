# frozen_string_literal: true

class AgendaType < ApplicationRecord
  # search
  include PgSearch::Model
  pg_search_scope(:search, against: :name, using: { tsearch: { prefix: true } })

  # callbacks
  before_save :capitalize_attributes

  # relations
  has_many :agendas, dependent: :nullify

  # validations
  validates :name, presence: true, length: { maximum: 255 }

  private

  def capitalize_attributes
    self.name = name.capitalize_turkish
  end
end
