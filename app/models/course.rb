# frozen_string_literal: true

class Course < ApplicationRecord
  # search
  include DynamicSearch
  include PgSearch

  pg_search_scope(
    :search,
    against: %i[name code],
    using: { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :course_type_id, :program_type, :language_id, :unit_id, :status

  # enumerations
  enum program_type: { associate: 0, undergraduate: 1, master: 2, doctoral: 3 }
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :course_type
  belongs_to :unit
  belongs_to :language

  # validations
  validates :name, presence: true, uniqueness: { scope: :unit_id }, length: { maximum: 255 }
  validates :code, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :theoric, numericality: { greater_than_or_equal_to: 0 }
  validates :practice, numericality: { greater_than_or_equal_to: 0 }
  validates :laboratory, numericality: { greater_than_or_equal_to: 0 }
  validates :credit, numericality: { greater_than_or_equal_to: ->(course) { course.course_type.try(:min_credit).to_i }
  }
  validates :program_type, inclusion: { in: program_types.keys }
  validates :status, inclusion: { in: statuses.keys }

  # callbacks
  before_validation do
    self.name = name.capitalize_all if name
    self.credit = calculate_credit
  end

  def calculate_credit
    theoric.to_f + ((practice.to_f + laboratory.to_f) / 2)
  end

  def name_with_code
    "#{code} - #{name}"
  end
end
