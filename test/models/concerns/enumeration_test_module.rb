# frozen_string_literal: true

module EnumerationTestModule
  extend ActiveSupport::Concern

  class_methods do
    # Examples
    # has_enum({ fall: 0, spring: 1, summer: 2 }, 'term')
    # has_enum({ fall: 0, spring: 1, summer: 2 }, 'term', academic_term(:term_one))

    def has_enum(enum_list, enumerated_attribute, object = nil)
      enum_list.each do |key, value|
        test "#{object} has a enum key (#{key}) with a value of #{value}" do
          object ||= class_name.delete_suffix('Test').constantize.take
          values = object.defined_enums[enumerated_attribute].with_indifferent_access
          assert_equal values[key], value
        end
      end
    end
  end
end
