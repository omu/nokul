# frozen_string_literal: true

class AcademicCalendar < ApplicationRecord
  # relations
  belongs_to :academic_term
  belongs_to :calendar_type

  # validations
  validates :name, :senatus_consultum_no, presence: true
  validates :academic_term_id, uniqueness: { scope: :calendar_type_id }
end
