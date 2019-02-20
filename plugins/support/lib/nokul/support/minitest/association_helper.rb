# frozen_string_literal: true

module Nokul
  module Support
    module Minitest
      module AssociationHelper
        SUFFIX = 'Test'
        RELATIONS = %i[belongs_to has_many has_one has_and_belongs_to_many].freeze

        RELATIONS.each do |relation|
          define_method(relation) do |attribute, **options|
            association = relations_for(relation, attribute)

            test "can respond to #{relation} #{attribute}" do
              assert association
              options.each do |key, value|
                assert_equal association.options[key], value, "Option: #{key}"
              end
            end
          end
        end

        def accepts_nested_attributes_for(attribute, **options)
          nested_attributes_options = klass.nested_attributes_options[attribute]

          test "#{attribute} must be nested attribute" do
            assert nested_attributes_options
            options.each do |key, value|
              assert_equal nested_attributes_options[key], value, "Option: #{key}"
            end
          end
        end

        private

        def relations_for(relation, attribute)
          klass.reflect_on_all_associations(relation).select do |association|
            association.name == attribute
          end.first
        end

        def klass
          to_s.delete_suffix(SUFFIX).constantize
        end
      end
    end
  end
end
