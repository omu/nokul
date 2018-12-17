# frozen_string_literal: true

class Document < ApplicationRecord
  # relations
  has_many :registration_documents, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :statement, length: { maximum: 255 }
end
