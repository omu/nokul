# frozen_string_literal: true

module ReferenceValidations
  extend ActiveSupport::Concern

  included do
    validates :name, :code,
              presence: true, uniqueness: true
  end
end
