# frozen_string_literal: true

class AvailableCourseGroup < ApplicationRecord
  # relations
  belongs_to :available_course
  has_many :lecturers, class_name: 'AvailableCourseLecturer', dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: { scope: :available_course }
  validates :quota, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_blank: true
end
