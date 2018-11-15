# frozen_string_literal: true

class AvailableCourse < ApplicationRecord
  # relations
  belongs_to :academic_term
  belongs_to :curriculum
  belongs_to :course
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy

  # validations
  validates :course, uniqueness: { scope: %i[academic_term curriculum] }
end
