# frozen_string_literal: true

class EducationInformation < ApplicationRecord
  # enums
  enum activity: { deleted: 0, active: 1 }
  enum location: { domestic: 0, abroad: 1 }
  enum thesis_step: { preparing: 1, completed: 3, subject_and_advisor_undetermined: 4 }
  enum program: {
    associate:                     1,
    undergraduate_major:           2,
    undergraduate_double_major:    3,
    undergraduate_minor:           4,
    master_with_thesis:            5,
    master_without_thesis:         6,
    master_evening_without_thesis: 7,
    integrated_doctoral:           8,
    proficiency_in_art:            9,
    doctoral:                      10,
    expertise_in_medicine:         11,
    minor_expertise_in_medicine:   12
  }

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # validations
  validates :unit_id, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_name, length: { maximum: 255 }
  validates :activity, allow_nil: true, inclusion: { in: activities.keys }
  validates :advisor, length: { maximum: 255 }
  validates :advisor_id_number, numericality: { only_integer: true, equal_to: 11 }
  validates :department, length: { maximum: 255 }
  validates :diploma_equivalency, length: { maximum: 255 }
  validates :diploma_no, length: { maximum: 100 }
  validates :faculty, length: { maximum: 255 }
  validates :location, inclusion: { in: locations.keys }
  validates :other_discipline, length: { maximum: 255 }
  validates :other_university, length: { maximum: 255 }
  validates :program, inclusion: { in: programs.keys }
  validates :thesis_name, length: { maximum: 255 }
  validates :thesis_step, allow_nil: true, inclusion: { in: thesis_steps.keys }
  validates :university_id, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :university_name, length: { maximum: 255 }
  validates :yoksis_id, uniqueness: { scope: :user }, numericality: { only_integer: true, greater_than: 0 }
  validates :start_year, numericality: { only_integer:             true,
                                         greater_than_or_equal_to: 1950,
                                         less_than_or_equal_to:    2050 }
  validates :start_of_thesis, allow_nil: true, numericality: { only_integer:             true,
                                                               greater_than_or_equal_to: 1950,
                                                               less_than_or_equal_to:    2050 }
  validates :end_year, allow_nil: true, numericality: { only_integer:             true,
                                                        greater_than_or_equal_to: 1950,
                                                        less_than_or_equal_to:    2050 }
end
