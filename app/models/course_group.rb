# frozen_string_literal: true

class CourseGroup < ApplicationRecord
  include ExceptFor
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name unit_id course_group_type_id],
    associated_against: { unit: :name, course_group_type: :name },
    using: { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :unit
  belongs_to :course_group_type
  has_many :group_courses, dependent: :destroy
  has_many :courses, through: :group_courses

  # validations
  validates :name, presence: true
  validates :total_ects_condition, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :course_ids, presence: true

  # callbacks
  before_save { self.name = name.capitalize_all }
end
