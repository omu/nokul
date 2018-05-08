# frozen_string_literal: true

module ReferenceValidations
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true, numericality: { only_integer: true }
  end
end
