# frozen_string_literal: true

module Patron
  module Scope
    module Query
      class Parameter
        attr_accessor :name, :query_type, :skip_empty, :value

        def initialize(**args)
          @name       = args[:name]
          @query_type = args[:query_type]
          @skip_empty = ActiveModel::Type::Boolean.new.cast(args[:skip_empty])
          @value      = args[:value]
        end

        def to_arel_for(model)
          Query::Arel.public_send(query_type, model, name, value) if assignable?
        end

        private

        def assignable?
          value.present? || !skip_empty
        end
      end
    end
  end
end
