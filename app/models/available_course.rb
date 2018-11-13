# frozen_string_literal: true

class AvailableCourse < ApplicationRecord
  # relations
  belongs_to :academic_term
  belongs_to :course
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy
end
