# frozen_string_literal: true

module Regulation
  class Article
    module Configuration
      extend ActiveSupport::Concern

      def name(name = nil)
        @_name ||= name
      end

      def identifier(name = nil)
        @_identifier ||= name
      end

      def version(version = nil)
        @_version ||= version
      end

      def number(number = nil)
        @_number ||= number
      end

      def sub_articles(*keys)
        @_sub_articles ||= keys
      end

      def register(*klasses)
        valid!

        klasses.each do |klass|
          klass.register(identifier,
                         class:        self,
                         name:         name,
                         version:      version,
                         number:       number,
                         sub_articles: sub_articles)
        end
      end

      def valid!
        %i[
          name
          identifier
          number
          version
        ].each do |property|
          next if public_send(property).present?

          raise ArgumentError, "#{property} property should not be empty"
        end
      end
    end

    extend Configuration
    include Store
  end
end
