# frozen_string_literal: true

module Regulation
  module Store
    extend ActiveSupport::Concern

    class_methods do
      def store
        @_store ||= yield
      end
    end

    def store_data
      self.class.store
    end
  end
end
