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
        article = find_article(identifier)
        article.klass.call(*params, store_key: article.store)
      end

      def find_article(identifier)
        fetch(identifier) { raise "article not found for #{identifier}" }
      end
    end
  end
end
