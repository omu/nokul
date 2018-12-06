# frozen_string_literal: true

class AvailableCourseLecturer < ApplicationRecord
  # relations
  belongs_to :group, class_name: 'AvailableCourseGroup'
  belongs_to :lecturer, class_name: 'Employee'

  # validations
  validates :coordinator, inclusion: { in: [true, false] }
  validates :lecturer_id, uniqueness: { scope: :group }

  # scopes
  scope :coordinator, -> { where(coordinator: true) }

  delegate :title, :identities, to: :lecturer
end
