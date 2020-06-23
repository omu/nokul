# frozen_string_literal: true

module Extensions
  module Regulation
    class Clause
      module Configuration
        extend ActiveSupport::Concern

        def attributes(*args)
          @_attributes ||= Set.new
          args.each { |arg| @_attributes.add arg }
          @_attributes
        end

        def display_name
          I18n.t(i18n_key)
        end

        def i18n_key(key = nil)
          @i18n_key ||= key || "regulations.clauses/#{version}.#{identifier}"
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

      attr_reader :store_key, :executer

      def initialize(*params, executer:)
        define_instance_variables(params)

        unless executer.is_a?(Class) && executer&.superclass == Regulation::Base
          raise ArgumentError, 'executer type must be Regulation'
        end

        @executer  = executer
        @store_key = executer.fetch(identifier).store
      end

      class << self
        def call(*params, **config)
          new(*params, **config).call
        end
      end

      delegate :identifier, :attributes, to: :class

      private

      def define_instance_variables(params)
        unless params.size == attributes.size
          raise ArgumentError, "Wrong number of arguments (given #{params.size}, expected #{attributes.length})"
        end

        attributes.zip(params).each { |attr, param| instance_variable_set("@#{attr}", param) }

        # define reader
        self.class.attr_reader(*attributes)
      end
    end
  end
end
