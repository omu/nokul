# frozen_string_literal: true

module ReferenceCallbacks
  extend ActiveSupport::Concern

  included do
    before_validation :capitalize_attributes

    private

    def capitalize_attributes
      self.name = name.capitalize_turkish if name
    end
  end
end
