# frozen_string_literal: true

class EducationInformation < ApplicationRecord
  # enums
  enum activity: { passive: 0, active: 1 }
  enum location: { domestic: 1, abroad: 2 }

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # validations
  validates :activity, allow_nil: true, inclusion: { in: activities.keys }
  validates :advisor, length: { maximum: 255 }
  validates :advisor_id_number, allow_nil: true, numericality: { only_integer: true }, length: { is: 11 }
  validates :department, length: { maximum: 255 }
  validates :diploma_equivalency, length: { maximum: 255 }
  validates :diploma_no, length: { maximum: 100 }
  validates :discipline, length: { maximum: 255 }
  validates :end_date_of_thesis, allow_nil: true, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 1950,
    less_than_or_equal_to:    2050
  }
  validates :end_year, allow_nil:    true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050 }
  validates :faculty, length: { maximum: 255 }
  validates :location, inclusion: { in: locations.keys }
  validates :other_discipline, length: { maximum: 255 }
  validates :other_university, length: { maximum: 255 }
  validates :program, presence: true, length: { maximum: 255 }
  validates :start_date_of_thesis, allow_nil: true, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 1950,
    less_than_or_equal_to:    2050
  }
  validates :start_year, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 1950,
    less_than_or_equal_to:    2050
  }
  validates :thesis_name, length: { maximum: 255 }
  validates :thesis_step, length: { maximum: 100 }
  validates :unit_id, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :university, length: { maximum: 255 }
  validates :yoksis_id, uniqueness: { scope: :user }, numericality: { only_integer: true, greater_than: 0 }
end
