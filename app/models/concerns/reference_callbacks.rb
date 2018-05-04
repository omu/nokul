# frozen_string_literal: true

module ReferenceCallbacks
  extend ActiveSupport::Concern

  included do
    before_save do
      self.name = name.mb_chars.titlecase
    end
  end
end
