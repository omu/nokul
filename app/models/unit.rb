# frozen_string_literal: true

class Unit < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name yoksis_id],
    using: { tsearch: { prefix: true } }
  )

  # relations
  has_ancestry
  belongs_to :district
  belongs_to :unit_status
  belongs_to :unit_type, optional: true
  belongs_to :unit_instruction_type, optional: true
  belongs_to :unit_instruction_language, optional: true
  belongs_to :university_type, optional: true
  has_many :duties, dependent: :destroy
  has_many :employees, through: :duties
  has_many :students, dependent: :nullify
  has_many :users, through: :employees
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties

  # validations
  validates :yoksis_id, uniqueness: true, allow_blank: true, numericality: { only_integer: true }
  validates :detsis_id, uniqueness: true, allow_blank: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { scope: %i[ancestry unit_status] }
  validates :duration, numericality: { only_integer: true }, allow_blank: true

  # callbacks
  before_save { self.name = name.capitalize_all }

  # dynamic search scopes
  scope :duration, ->(time) { where(duration: time) }
  scope :unit_status_id, ->(id) { where(unit_status_id: id) }
  scope :unit_instruction_type_id, ->(id) { where(unit_instruction_type_id: id) }
  scope :unit_instruction_language_id, ->(id) { where(unit_instruction_language_id: id) }
end
