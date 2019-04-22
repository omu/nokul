# frozen_string_literal: true

require 'pry'
module Patron
  module Scope
    module Store
      module Validation
        extend ActiveSupport::Concern

        included do
          before_validation :set_accessors_validations, if: :scope_name?

          def set_accessors_validations
            [*scope_klass&.filter_attributes].each do |filter|
              unless skip_empty_for?(filter)
                validates_presence_of "#{filter}_value".to_sym
                validates_presence_of "#{filter}_query_type".to_sym
              end
              validates_inclusion_of "#{filter}_skip_empty".to_sym, in: %w[true false]
            end
          end

          def skip_empty_for?(filter)
            ActiveModel::Type::Boolean.new.cast(
              public_send("#{filter}_skip_empty")
            )
          end
        end
      end
    end
  end
end
