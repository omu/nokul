# frozen_string_literal: true

class Language < ApplicationRecord
  # search
  include ReferenceSearch

  # relations
  has_many :courses, dependent: :nullify
  has_many :prospective_students, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :iso, presence: true, uniqueness: true, length: { maximum: 255 }

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.iso  = iso.upcase(:turkic)
  end
end
