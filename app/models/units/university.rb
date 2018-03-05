class University < ApplicationRecord
  # relations
  belongs_to :city

  # validations
  validates :name, :short_name, :yoksis_id, presence: true, uniqueness: true, strict: true

  # OPTIMIZE: Logic may be moved into a module/class along with university in the future.
  enum type: [:public, :private]
end
