# frozen_string_literal: true

module EnumerationTestModule
  extend ActiveSupport::Concern

  class_methods do
    # Examples
    # has_enum :term, values: { fall: 0, spring: 1, summer: 2 }
    # has_enum :term, values: { fall: 0, spring: 1, summer: 2 }, object: AcademicTerm.first

    def has_enum(enumerated_attribute, enums, object: nil)
      enums = enums[:values]
      enums.each do |key, value|
        test "#{object} has a enum key (#{key}) with a value of #{value}" do
          object ||= class_name.delete_suffix('Test').constantize.take
          enums = object.defined_enums[enumerated_attribute.to_s].with_indifferent_access
          assert_equal enums[key], value
        end
      end
    end
  end
end
