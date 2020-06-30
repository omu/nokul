# frozen_string_literal: true

class AvailableCourseGroup < ApplicationRecord
  # callbacks
  before_destroy :must_be_another_group

  # relations
  belongs_to :available_course, counter_cache: :groups_count
  has_many :course_enrollments, dependent: :destroy
  has_many :lecturers, class_name: 'AvailableCourseLecturer', foreign_key: :group_id,
                       inverse_of: :group, dependent: :destroy
  has_many :saved_enrollments, -> { saved }, class_name: 'CourseEnrollment',
                                             inverse_of: :available_course

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
    saved_enrollments.count
  end

  private

  def must_be_another_group
    throw(:abort) if available_course.groups.where.not(id: id).empty? && !destroyed_by_association
  end
end
