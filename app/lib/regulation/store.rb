# frozen_string_literal: true

module Regulation
  module Store
    extend ActiveSupport::Concern

    class_methods do
      def store(name = :default)
        stores[name] ||= yield
      end

      def stores
        @_stores ||= {}
      end
    end

    def store(name = store_key)
      self.class.stores[name] || raise("No store defined for key #{store_key}")
    end
  end
end
