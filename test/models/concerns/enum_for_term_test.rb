# frozen_string_literal: true

module EnumForTermTest
  extend ActiveSupport::Concern

  # callbacks
  class_methods do
    def test_term_enum(klass)
      { fall: 0, spring: 1, summer: 2 }.each do |key, value|
        test "have a #{key} value of term enum" do
          values = klass.defined_enums['term'].with_indifferent_access
          assert_equal values[key], value
        end
      end
    end
  end
end
