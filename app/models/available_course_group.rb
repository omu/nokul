# frozen_string_literal: true

class AvailableCourseGroup < ApplicationRecord
  # relations
  belongs_to :available_course, counter_cache: :groups_count
  has_many :course_enrollments, dependent: :destroy
  has_many :lecturers, class_name: 'AvailableCourseLecturer', foreign_key: :group_id,
                       inverse_of: :group, dependent: :destroy

  # nested models
  accepts_nested_attributes_for :lecturers, reject_if: :all_blank, allow_destroy: true

  # validations
  validates :lecturers, presence: { message: :cannot_empty }
  validates :name, presence: true, uniqueness: { scope: :available_course }, length: { maximum: 255 }
  validates :quota, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates_associated :lecturers

  # custom methods
  def quota_full?
    quota == number_of_enrolled_students
  end

  def number_of_enrolled_students
    course_enrollments.saved.count
  end
end
