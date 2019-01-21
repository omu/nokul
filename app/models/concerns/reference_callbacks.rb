# frozen_string_literal: true

module ReferenceCallbacks
  extend ActiveSupport::Concern

  included do
    before_validation { self.name = name.capitalize_turkish if name }
  end
end
