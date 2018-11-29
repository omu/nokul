# frozen_string_literal: true

class CurriculumCourse < ApplicationRecord
  # relations
  belongs_to :course
  belongs_to :curriculum_semester

  # validations
  validates :ects, presence: true, numericality: { greater_than: 0 }

  # delegates
  delegate :code, :credit, :name, to: :course
end
