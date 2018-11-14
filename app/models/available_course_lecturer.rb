# frozen_string_literal: true

class AvailableCourseLecturer < ApplicationRecord
  # relations
  belongs_to :group, class_name: 'AvailableCourseGroup'
  belongs_to :lecturer, class_name: 'Employee'

  # validations
  validates :coordinator, presence: true, inclusion: { in: [true, false] }

  # scopes
  scope :coordinator, -> { where(coordinator: true) }
end
