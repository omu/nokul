# frozen_string_literal: true

class CourseUnitGroup < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :course_group_type

  # validations
  validates :name, presence: true
  validates :total_ects_condition, presence: true

  # callbacks
  before_save { self.name = name.capitalize_all }
end
