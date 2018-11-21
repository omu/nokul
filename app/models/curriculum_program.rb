# frozen_string_literal: true

class CurriculumProgram < ApplicationRecord
  belongs_to :unit
  belongs_to :curriculum
end
