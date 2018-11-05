# frozen_string_literal: true

class CurriculumSemester < ApplicationRecord
  # relations
  belongs_to :curriculum, counter_cache: :semesters_count

  # validations
  validates :name, presence: true, uniqueness: { scope: :curriculum_id }
  validates :sequence, numericality: { greater_than: 0 }, uniqueness: { scope: :curriculum_id }
end
