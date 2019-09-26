# frozen_string_literal: true

module Patron
  module Scope
    module Store
      module Accessor
        extend ActiveSupport::Concern

        def accessors
          @_accessors ||= Set.new
        end

        def permitted_attributes
          @_permitted_attributes ||= Set.new
        end

        ACCESSORS_SUFFIXES = %w[
          dynamic_query_type
          dynamic_value
          static_query_type
          static_value
          value_type
          skip_empty
        ].freeze

        # AccessorDefiner
        module AccessorDefiner
          def define_accessor_methods(accessor, filter, suffix)
            accessors << accessor

            # Getter
            define_singleton_method(accessor) { parameters_for(filter)[suffix] }

            # Setter
            define_singleton_method("#{accessor}=") do |value|
              parameters_for(filter)[suffix] = standardize(value)
            end
          end

          def standardize(value)
            value.is_a?(Array) ? value.select(&:present?) : value
          end

          def parameters_for(accessor)
            parameters[accessor] = {} unless parameters.key?(accessor)
            parameters[accessor]
          end
        end

        # PermittedAttributeDefiner
        module PermittedAttributeDefiner
          def define_permitted_attributes(accessor, suffix, option)
            permitted_attributes << if suffix == 'static_value' && option.multiple
                                      { accessor => [] }
                                    else
                                      accessor
                                    end
          end
        end

        included do
          after_initialize :define_dynamic_accessors

          include AccessorDefiner
          include PermittedAttributeDefiner

          def value_for(attribute, suffix, i18n_method: nil)
            value = public_send("#{attribute}_#{suffix}")

            return value if i18n_method.nil? || value.blank?

            Patron::Utils::I18n.public_send(i18n_method, value)
          end

          private

          def define_dynamic_accessors
            return if scope_klass.nil?

            scope_klass.filters.each do |filter, option|
              ACCESSORS_SUFFIXES.each do |suffix|
                accessor = "#{filter}_#{suffix}"

                define_accessor_methods(accessor, filter, suffix)
                define_permitted_attributes(accessor.to_sym, suffix, option)
              end
            end
          end

          def scope_klass
            @_scope_klass ||= name.safe_constantize
          end
        end
      end
    end
  end
end
