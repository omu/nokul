# frozen_string_literal: true

class CourseUnitGroup < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :course_group_type
  has_many :group_courses, dependent: :destroy
  has_many :courses, through: :group_courses

  # validations
  validates :name, presence: true
  validates :total_ects_condition, presence: true
  validates :course_ids, presence: true

  # callbacks
  before_save { self.name = name.capitalize_all }
end
