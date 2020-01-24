# frozen_string_literal: true

class SourceBook < ApplicationRecord
  enum status: [:inactive, :active]

  belongs_to :unit

  has_many :questions

  validates :unit_id, presence: true

  validates :edition, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :publish_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name, presence: true, length: { maximum: 100 }
  validates :isbn, presence: true, length: { maximum: 50 }
  validates :author, presence: true, length: { maximum: 150 }
  validates :image, length: { maximum: 1.megabytes, message: 'Maximum 1MB', if: :image? }
  validates :explanation, length: { maximum: 400 }

  mount_uploader :image, SourceBookImageUploader

  before_save lambda {
    self.name = name.squish if name.presence
    self.isbn = isbn.delete(' ') if isbn.presence
    self.author = author.squish if author.presence
    self.explanation = explanation.squish if explanation.presence
  }

  def self.editions
    (1..40)
  end

  def self.years
    (1900..Time.current.year).to_a.reverse
  end
end
