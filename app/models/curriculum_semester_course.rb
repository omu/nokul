# frozen_string_literal: true

class CurriculumSemesterCourse < ApplicationRecord
  # relations
  belongs_to :course
  belongs_to :curriculum_semester

  # delegates
  delegate :code, :credit, :name, to: :course
end
