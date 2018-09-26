# frozen_string_literal: true

class UnitCurriculum < ApplicationRecord
  belongs_to :unit
  belongs_to :curriculum
end
