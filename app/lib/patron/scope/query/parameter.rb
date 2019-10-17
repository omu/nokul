# frozen_string_literal: true

module Patron
  module Scope
    module Query
      class Parameter
        attr_accessor :name, :query_type, :skip_empty, :value

        def initialize(**args)
          @name       = args[:name]
          @query_type = prepare_query_type(args)
          @skip_empty = ActiveModel::Type::Boolean.new.cast(args[:skip_empty])
          @value      = prepare_value(args)
        end

        def to_arel_for(scope_klass)
          return unless assignable? && scope_klass.filter?(name)

          Query::Arel.public_send(query_type, scope_klass.model, name, value)
        end

        private

        def assignable?
          value.present? || !skip_empty
        end

        def prepare_value(args)
          case args[:value_type]
          when 'static'  then args[:static_value]
          when 'dynamic' then args[:instance].try("#{args[:dynamic_value]}_value")
          end
        end

        def prepare_query_type(args)
          case args[:value_type]
          when 'static'  then args.fetch(:static_query_type)
          when 'dynamic' then args.fetch(:dynamic_query_type)
          end
        end
      end
    end
  end
end
