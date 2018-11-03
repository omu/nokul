# frozen_string_literal: true

class CourseGroupType < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(:search, against: :name, using: { tsearch: { prefix: true } })

  # relations
  has_many :course_unit_groups, dependent: :nullify

  # validations
  validates :name, presence: true

  # callbacks
  before_save { self.name = name.titleize_tr }
end
