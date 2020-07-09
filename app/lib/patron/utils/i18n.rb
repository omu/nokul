# frozen_string_literal: true

module Patron
  module Utils
    module I18n
      module_function

      def filter(name, class_name:)
        ::I18n.translate(name, scope: [:activerecord, :attributes, class_name.to_s.underscore])
      end

      %w[
        label
        query_type
        skip_empty
        value_type
      ].each do |method_name|
        define_method(method_name) do |name|
          ::I18n.translate(name, scope: [:patron, method_name.to_s.pluralize])
        end
      end

      def collection(collection, attribute:)
        [*collection].map do |item|
          [public_send(attribute, item), item]
        end
      end
    end
  end
end
