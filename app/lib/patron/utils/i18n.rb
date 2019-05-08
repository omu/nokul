# frozen_string_literal: true

module Patron
  module Utils
    module I18n
      module_function

      def translate_filter(name, class_name:)
        translate(name, scope: [:activerecord, :attributes, class_name.to_s.underscore])
      end

      def translate_suffix(name)
        translate(name, scope: %i[patron suffixes])
      end

      def translate_query_type(name)
        translate(name, scope: %i[patron query_types])
      end

      def translate_skip_empty(name)
        translate(name, scope: %i[patron boolean])
      end

      def translate_collection_for_boolean(collection)
        [*collection].map do |item|
          [translate_skip_empty(item), item]
        end
      end

      def translate_collection_for_query_types(collection)
        [*collection].map do |item|
          [translate_query_type(item), item]
        end
      end

      def translate(name, **options)
        return '' if name.blank?

        ::I18n.translate(name, options)
      end

      private_class_method :translate
    end
  end
end
