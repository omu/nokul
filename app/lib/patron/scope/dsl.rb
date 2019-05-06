# frozen_string_literal: true

module Patron
  module Scope
    module Dsl
      def preview_attributes(*attributes)
        @preview_attributes ||= (attributes.presence || filter_attributes).each_with_object({}) do |item, hash|
          case item
          when Symbol, String then hash[item] = item
          when Hash           then hash.merge!(item)
          end
        end
      end

      def filter(attribute, **options)
        exist!(attribute)

        filters[attribute] = Option.new(attribute, options)
      end

      def filters
        @_filters ||= {}
      end

      def filter_attributes
        filters.keys
      end

      def filter?(name)
        filters.key?(name.to_s.to_sym)
      end

      private

      def exist!(attribute)
        return if model.attribute_names.include?(attribute.to_s)

        raise ArgumentError, "Unrecognized attribute: #{attribute}"
      end

      class Option
        SUPPORTED_TYPES = %i[string array].freeze

        attr_reader :collection,
                    :type,
                    :multiple,
                    :i18n_key

        def initialize(attribute, **args)
          @collection = collection_to_proc(args)
          @multiple   = args.fetch(:multiple, false)
          @type       = forecast_type(args)
          @i18n_key   = args.fetch(:i18n_key, attribute)
          check!
        end

        def forecast_type(args)
          return :array unless collection.call.nil?

          args.fetch(:type, :string)
        end

        def field_type
          return :select if collection.call.present?

          case type
          when :string then :string
          when :array  then :select
          else              :string
          end
        end

        def collection?
          type == :array
        end

        private

        def collection_to_proc(args)
          collection = args.fetch(:collection, proc { nil })

          case collection
          when Proc         then collection
          when Array, Range then proc { collection }
          else
            raise ArgumentError, "Unsupported data type (#{collection.class}), "\
                                  'collection can only be in Array, Range and Proc types'
          end
        end

        def check!
          return if SUPPORTED_TYPES.include? type.to_sym

          raise ArgumentError, "Unsupport type, supported types #{SUPPORTED_TYPES.join(',')}"
        end
      end

      private_constant :Option
    end
  end
end
