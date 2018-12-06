# frozen_string_literal: true

class AvailableCourse < ApplicationRecord
  # search
  include DynamicSearch

  # dynamic_search
  search_keys :curriculum_id, :academic_term_id

  # relations
  belongs_to :academic_term
  belongs_to :curriculum
  belongs_to :course
  belongs_to :unit
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy

  # validations
  validates :course, uniqueness: { scope: %i[academic_term curriculum] }

  # delegates
  delegate :code, :name, :theoric, :practice, :laboratory, :credit, :program_type, to: :course
  delegate :name, to: :curriculum, prefix: true
  delegate :name, to: :unit, prefix: true
end
