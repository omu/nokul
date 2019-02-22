# frozen_string_literal: true

module Nokul
  module Support
    module Minitest
      module EnumerationHelper
        def enum(definitions)
          definitions.each do |attribute, values|
            values.each do |key, value|
              test "has a enum key (#{key}) with a value of #{value}" do
                klass         = class_name.delete_suffix('Test').constantize
                defined_value = klass.defined_enums.dig(attribute.to_s, key.to_s)
                assert_equal defined_value, value, "Enum: #{attribute}"
              end
            end
          end
        end
      end
    end
  end
end
