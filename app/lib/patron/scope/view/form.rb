# frozen_string_literal: true

module Patron
  module Scope
    module View
      module Form
        Field = Struct.new(
          :type,
          :for,
          :name,
          :as,
          :collection,
          :required,
          :multiple,
          :label,
          keyword_init: true
        )

        def fields_for_form
          filters.each_with_object({}) do |(filter, option), hash|
            hash[translate_filter(option.i18n_key)] = [
              generate_field_for_value_type(filter),
              generate_field_for_static_value(filter, option),
              generate_field_for_static_query_type(filter, option),
              generate_field_for_dynamic_value(filter),
              generate_field_for_dynamic_query_type(filter),
              generate_field_for_skip_empty(filter)
            ].compact
          end
        end

        private

        def generate_field_for_static_value(filter, option)
          Field.new(
            type:       :value,
            for:        :static,
            name:       "#{filter}_static_value",
            as:         option.field_type,
            collection: option.collection,
            multiple:   option.multiple,
            label:      Utils::I18n.label('static_value')
          )
        end

        def generate_field_for_static_query_type(filter, option)
          Field.new(
            type:       :query_type,
            for:        :static,
            name:       "#{filter}_static_query_type",
            as:         :select,
            collection: Utils::I18n.collection(arel_predicates_for(option.type), attribute: :query_type),
            required:   false,
            label:      Utils::I18n.label('static_query_type')
          )
        end

        def generate_field_for_skip_empty(filter)
          Field.new(
            type:       :skip_empty,
            name:       "#{filter}_skip_empty",
            collection: Utils::I18n.collection(%w[true false], attribute: :skip_empty),
            as:         :select,
            label:      Utils::I18n.label('skip_empty')
          )
        end

        def generate_field_for_dynamic_value(filter)
          collection = dynamic_values.dig(:scopes, filter.to_sym)

          return if collection.nil?

          Field.new(
            type:       :dynamic_value,
            for:        :dynamic,
            name:       "#{filter}_dynamic_value",
            collection: collection,
            as:         :select,
            label:      Utils::I18n.label('dynamic_value')
          )
        end

        def generate_field_for_dynamic_query_type(filter)
          return unless dynamic_values.dig(:scopes, filter.to_sym)

          Field.new(
            type:       :dynamic_query_type,
            for:        :dynamic,
            name:       "#{filter}_dynamic_query_type",
            as:         :select,
            collection: Utils::I18n.collection(Query::Arel.predicates, attribute: :query_type),
            required:   false,
            label:      Utils::I18n.label('dynamic_query_type')
          )
        end

        def generate_field_for_value_type(filter)
          collection = dynamic_values.dig(:scopes, filter.to_sym) ? %i[static dynamic] : [:static]

          Field.new(
            type:       :value_type,
            name:       "#{filter}_value_type",
            collection: Utils::I18n.collection(collection, attribute: :value_type),
            as:         :select,
            label:      Utils::I18n.label('value_type')
          )
        end

        def arel_predicates_for(type)
          case type
          when :array  then %i[in not_in]
          when :string then Query::Arel.predicates.to_a - %i[in not_in]
          else              []
          end
        end

        def translate_filter(key)
          Utils::I18n.filter(key, class_name: model)
        end
      end
    end
  end
end
