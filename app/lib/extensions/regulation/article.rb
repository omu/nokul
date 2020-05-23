# frozen_string_literal: true

module Extensions
  module Regulation
    class Article
      module Configuration
        extend ActiveSupport::Concern

        def display_name
          I18n.t(i18n_key)
        end

        def i18n_key(key = nil)
          @i18n_key ||= key || "regulations.articles/#{version}.#{identifier}"
        end

        def version
          @_version ||= name.split('::')[1].downcase
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
            klass.register(identifier, metadata: metadata.merge(klass: self, identifier: identifier))
          end
        end

        def valid!
          %i[
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
end
