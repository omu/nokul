# frozen_string_literal: true

module ReferenceCallbacks
  extend ActiveSupport::Concern

  included do
    before_save { self.name = name.titleize_tr }
  end
end
