# frozen_string_literal: true

class Course < ApplicationRecord
  # search
  include DynamicSearch
  include PgSearch

  pg_search_scope(
    :search,
    against: %i[name code],
    using:   { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :course_type_id, :program_type, :language_id, :unit_id, :status

  # callbacks
  before_validation :capitalize_attributes
  before_validation :assign_credit

  # enumerations
  enum program_type: { associate: 0, undergraduate: 1, master: 2, doctoral: 3 }
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :course_type
  belongs_to :language
  belongs_to :unit

  # validations
  validates :code, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :credit, numericality: { greater_than_or_equal_to: ->(course) { course.course_type.try(:min_credit).to_i } }
  validates :laboratory, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: { scope: :unit_id }, length: { maximum: 255 }
  validates :practice, numericality: { greater_than_or_equal_to: 0 }
  validates :program_type, inclusion: { in: program_types.keys }
  validates :status, inclusion: { in: statuses.keys }
  validates :theoric, numericality: { greater_than_or_equal_to: 0 }

  def name_with_code
    "#{code} - #{name}"
  end

  def calculate_credit
    theoric.to_f + ((practice.to_f + laboratory.to_f) / 2)
  end

  private

  def capitalize_attributes
    self.name = name.capitalize_turkish if name
  end

  def assign_credit
    self.credit = theoric.to_f + ((practice.to_f + laboratory.to_f) / 2)
  end
end
