# frozen_string_literal: true

module Regulation
  class Base
    extend Configuration

    class << self
      def articles
        @_articles ||= {}
      end

      delegate :fetch, to: :articles

      def call(identifier, *params)
        fetch(identifier)[:class].call(*params)
      end
    end
  end
end
