# frozen_string_literal: true

class EvaluationType < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  # callbacks
  before_validation { self.name = name.capitalize_turkish if name }
end
