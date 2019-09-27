# frozen_string_literal: true

class AcademicCredential < ApplicationRecord
  # enums
  enum activity: { deleted: 0, active: 1 }
  enum location: { domestic: 0, abroad: 1 }
  enum status: { full_time: 0, part_time: 1 }

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # validations
  validates :yoksis_id, uniqueness: { scope: :user }, numericality: { only_integer: true, greater_than: 0 }
  validates :activity, allow_nil: true, inclusion: { in: activities.keys }
  validates :department, length: { maximum: 255 }
  validates :discipline, length: { maximum: 255 }
  validates :location, allow_nil: true, inclusion: { in: locations.keys }
  validates :profession_name, length: { maximum: 255 }
  validates :scientific_field, length: { maximum: 255 }
  validates :status, allow_nil: true, inclusion: { in: statuses.keys }
  validates :title, length: { maximum: 255 }
  validates :unit_name, length: { maximum: 255 }
  validates :unit_id, numericality: { only_integer: true, greater_than: 0 }
  validates :university_id, numericality: { only_integer: true, greater_than: 0 }
  validates :university_name, presence: true, length: { maximum: 255 }
  validates :start_year, numericality: { only_integer: true,
                                         greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050 }
  validates :end_year, allow_nil:    true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050 }
end
