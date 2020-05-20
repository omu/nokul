# frozen_string_literal: true

module Regulation
  class Base
    module Configuration
      def name(name = nil)
        @_name ||= name
      end

      def identifier(name = nil)
        @_identifier ||= name
      end

      def version(version = nil)
        @_version ||= version
      end

      def register(identifier, metadata: {})
        articles[identifier] = Metadata.new(metadata)
      end

      def valid!
        %i[
          name
          identifier
        ].each do |property|
          next if public_send(property).present?

          raise ArgumentError, "#{property} property should not be empty"
        end
      end
    end

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
