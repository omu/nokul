# frozen_string_literal: true

module ReferenceValidations
  extend ActiveSupport::Concern

  included do
    validates :code, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  end
end
