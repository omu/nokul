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

      def regulations
        @_regulations ||= []
      end

      def register(*klasses, metadata: {})
        valid!

        klasses.each do |klass|
          regulations << klass
          klass.register(identifier, metadata: metadata.merge(klass: self, name: name))
        end
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
    include Store

    attr_reader :store_key

    def initialize(store_key: :default)
      @store_key = store_key
    end

    class << self
      def call(**params)
        new(**params).call
      end
    end
  end
end
