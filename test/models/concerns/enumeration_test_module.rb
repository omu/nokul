# frozen_string_literal: true

module EnumerationTestModule
  extend ActiveSupport::Concern

  class_methods do
    def has_enum(enumerated_attribute, **enums)
      enums.each do |key, value|
        test "has a enum key (#{key}) with a value of #{value}" do
          object = class_name.delete_suffix('Test').constantize.take
          object_enums = object.defined_enums[enumerated_attribute.to_s].with_indifferent_access
          assert_equal object_enums[key], value
        end
      end
    end
  end
end
