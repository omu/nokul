# frozen_string_literal: true

class DocumentType < ApplicationRecord
  # search
  include ReferenceSearch

  # relations
  has_many :registration_documents, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :active, inclusion: { in: [true, false] }
end
