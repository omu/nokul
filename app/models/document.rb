# frozen_string_literal: true

class Document < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
end
