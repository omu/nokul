# frozen_string_literal: true

module Extensions
  module Regulation
    class Metadata
      include Comparable

      def <=>(other)
        number <=> other.number
      end

      ATTRIBUTES = {
        description:  { required: false, default: '', types: [String] },
        identifier:   { required: true, types: [Symbol] },
        klass:        { required: true, types: [Regulation::Clause] },
        number:       { required: true, types: [String, Integer] },
        paragraph:    { required: false, default: [], types: [Array] },
        store:        { required: true, default: :default, types: [Symbol] },
        subparagraph: { required: false, default: [], types: [Array] },
        version:      { required: true, types: [String, Integer] }
      }.freeze

      ATTRIBUTES.each_key do |attr|
        attr_reader attr
      end

      def initialize(attributes = {})
        ATTRIBUTES.each do |attr, options|
          value = %i[paragraph subparagraph].include?(attr) ? [*attributes[attr]] : attributes[attr]

          instance_variable_set("@#{attr}", value || options[:default])
        end

        valid!
      end

      def sanitized_description
        sanitizer = Rails::Html::FullSanitizer.new
        sanitizer.sanitize description
      end

      def to_h
        ATTRIBUTES.keys.index_with { |attr| attr == :klass ? klass.to_s : public_send(attr) }
      end

      private

      def valid!
        ATTRIBUTES.each do |attr, options|
          required, types = options.values_at(:required, :types)
          data            = public_send(attr)

          next unless required

          raise ArgumentError, "#{attr} property should not be empty" if required && data.blank?

          next if types.any? { |type| type_checker(data, type) }

          raise ArgumentError, "#{attr} type must be #{'any of ' if types.count > 1}#{types.to_sentence}"
        end
      end

      def type_checker(data, type)
        data.is_a?(Class) ? data.superclass == type : data.is_a?(type)
      end
    end
  end
end
