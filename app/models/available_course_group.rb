# frozen_string_literal: true

class AvailableCourseGroup < ApplicationRecord
  # relations
  belongs_to :available_course, counter_cache: :groups_count
  has_many :lecturers, class_name: 'AvailableCourseLecturer', foreign_key: :group_id,
                       inverse_of: :group, dependent: :destroy

  # nested models
  accepts_nested_attributes_for :lecturers, reject_if: :all_blank, allow_destroy: true

  # validations
  validates :name, presence: true, uniqueness: { scope: :available_course }, length: { maximum: 255 }
  validates :quota, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_nil: true
end
