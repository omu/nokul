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
          @_fields_for_form ||= begin
            filters.map do |filter, option|
              [
                generate_field_for_value(filter, option),
                generate_field_for_query_type(filter, option),
                generate_field_for_skip_empty(filter, option)
              ]
            end
          end
        end

        private

        def generate_field_for_value(filter, option)
          Field.new(
            name: "#{filter}_value",
            as: option.field_type,
            collection: option.collection,
            multiple: option.multiple,
            label: label_for(option.i18n_key, 'value')
          )
        end

        def generate_field_for_query_type(filter, option)
          Field.new(
            name: "#{filter}_query_type",
            as: :select,
            collection: Utils::I18n.translate_collection_for_query_types(
              arel_predicates_for(option.type)
            ),
            required: true,
            label: label_for(option.i18n_key, 'query_type')
          )
        end

        def generate_field_for_skip_empty(filter, option)
          Field.new(
            name: "#{filter}_skip_empty",
            collection: Utils::I18n.translate_collection_for_boolean(
              %w[true false]
            ),
            as: :select,
            label: label_for(option.i18n_key, 'skip_empty')
          )
        end

        def arel_predicates_for(type)
          case type
          when :array  then %i[in not_in]
          when :string then Query::Arel.predicates.to_a - %i[in not_in]
          else              []
          end
        end

        def label_for(filter, suffix)
          [
            Utils::I18n.translate_filter(filter, class_name: model),
            Utils::I18n.translate_suffix(suffix)
          ].join(' - ')
        end
      end
    end
  end
end
