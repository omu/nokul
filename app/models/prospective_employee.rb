# frozen_string_literal: true

class ProspectiveEmployee < ApplicationRecord
  include PgSearch::Model
  include DynamicSearch
  include Prospective

  pg_search_scope(
    :search,
    against: %i[id_number staff_number first_name last_name],
    using:   { tsearch: { prefix: true } }
  )

  search_keys :unit_id, :title_id, :archived

  # callbacks
  before_create :normalize_string_attributes

  # relations
  belongs_to :unit
  belongs_to :user, optional: true, primary_key: :id_number, foreign_key: :id_number, inverse_of: :prospective_employees
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

  def registered_user(user)
    Employee.new(user: user, title_id: title_id, staff_number: staff_number)
  end

  private

  def normalize_string_attributes
    self.first_name = first_name.capitalize_turkish
    self.last_name  = last_name.upcase(:turkic)
  end
end
