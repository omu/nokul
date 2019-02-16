# frozen_string_literal: true

class CourseGroupType < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(:search, against: :name, using: { tsearch: { prefix: true } })

  # callbacks
  before_validation :capitalize_attributes

  # relations
  has_many :course_groups, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  # callbacks
  def capitalize_attributes
    self.name = name.capitalize_turkish if name
  end
end
