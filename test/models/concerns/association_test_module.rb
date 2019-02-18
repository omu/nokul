# frozen_string_literal: true

module AssociationTestModule
  extend ActiveSupport::Concern

  class_methods do
    %i[has_many has_one belongs_to].each do |method|
      # rubocop:disable Metrics/MethodLength
      define_method(method) do |*associations, **options|
        associations.each do |association|
          test "can respond to #{method} #{association}" do
            klass    = class_name.delete_suffix('Test').constantize
            relation = klass.reflect_on_all_associations(method).select do |item|
              item.name == association
            end.first

            assert relation
            options.each do |key, value|
              assert_equal relation.options[key], value, "Option: #{key}"
            end
          end
        end
      end
      # rubocop:enable Metrics/MethodLength
    end

    def accepts_nested_attributes_for(attribute, **options)
      test "#{attribute} must be nested attribute" do
        klass = class_name.delete_suffix('Test').constantize
        nested_attributes_options = klass.nested_attributes_options[attribute]

        assert nested_attributes_options
        options.each do |key, value|
          assert_equal nested_attributes_options[key], value, "Option: #{key}"
        end
      end
    end
  end
end
