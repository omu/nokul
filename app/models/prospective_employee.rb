# frozen_string_literal: true

class ProspectiveEmployee < ApplicationRecord
  include PgSearch
  include DynamicSearch
  include Prospective

  pg_search_scope(
    :search,
    against: %i[id_number staff_number first_name last_name],
    using: { tsearch: { prefix: true } }
  )

  search_keys :unit_id, :title_id, :archived

  # callbacks
  before_create :standardization

  # relations
  belongs_to :unit
  belongs_to :title

  # validations
  validates :date_of_birth, presence: true
  validates :email, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :id_number, presence: true, uniqueness: { scope: %i[unit_id] }, length: { is: 11 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :staff_number, presence: true, length: { maximum: 255 }
  validates_with EmailAddress::ActiveRecordValidator, field: :email

  # delegates
  delegate :name, to: :title, prefix: true

  def standardization
    self.first_name = first_name.capitalize_turkish
    self.last_name  = last_name.upcase(:turkic)
  end
end
