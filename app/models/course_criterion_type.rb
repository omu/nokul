# frozen_string_literal: true

class CourseCriterionType < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :identifier, presence: true, uniqueness: true, length: { maximum: 255 }

  # callbacks
  before_save { self.name = name.capitalize_all }
end
