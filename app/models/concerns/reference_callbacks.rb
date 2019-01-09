# frozen_string_literal: true

module ReferenceCallbacks
  extend ActiveSupport::Concern

  included do
    before_save { self.name = name.capitalize_turkish }
  end
end
