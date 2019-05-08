# frozen_string_literal: true

module Patron
  module Scope
    module View
      module Form
        Field = Struct.new(
          :name,
          :as,
          :collection,
          :required,
          :multiple,
          :label,
          keyword_init: true
        )

        def fields_for_form
          @fields_for_form ||= filters.each_with_object({}) do |(filter, option), hash|
            hash[translate_filter(option.i18n_key)] = [
              generate_field_for_value(filter, option),
              generate_field_for_query_type(filter, option),
              generate_field_for_skip_empty(filter)
            ]
          end
        end

        private

        def generate_field_for_value(filter, option)
          Field.new(
            name: "#{filter}_value",
            as: option.field_type,
            collection: option.collection,
            multiple: option.multiple,
            label: Utils::I18n.translate_suffix('value')
          )
        end

        def generate_field_for_query_type(filter, option)
          Field.new(
            name: "#{filter}_query_type",
            as: :select,
            collection: Utils::I18n.translate_collection_for_query_types(arel_predicates_for(option.type)),
            required: false,
            label: Utils::I18n.translate_suffix('query_type')
          )
        end

        def generate_field_for_skip_empty(filter)
          Field.new(
            name: "#{filter}_skip_empty",
            collection: Utils::I18n.translate_collection_for_boolean(%w[true false]),
            as: :select,
            label: Utils::I18n.translate_suffix('skip_empty')
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
          Utils::I18n.translate_filter(key, class_name: model)
        end
      end
    end
  end
end
