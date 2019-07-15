# frozen_string_literal: true

class CourseGroup < ApplicationRecord
  # search
  include DynamicSearch
  include PgSearch::Model

  pg_search_scope(
    :search,
    against: %i[name],
    using:   { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :unit_id, :course_group_type_id

  # callbacks
  before_validation :capitalize_attributes

  # relations
  belongs_to :course_group_type
  belongs_to :unit
  has_many :group_courses, dependent: :destroy
  has_many :courses, through: :group_courses
  has_many :curriculum_course_groups, dependent: :destroy

  # validations
  validates :course_ids, presence: true
  validates :name, presence: true, uniqueness: { scope: :unit_id }, length: { maximum: 255 }
  validates :total_ects_condition, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to:    300
  }

  private

  def capitalize_attributes
    self.name = name.capitalize_turkish if name
  end
end
