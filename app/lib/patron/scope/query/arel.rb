# frozen_string_literal: true

module Patron
  module Scope
    module Query
      module Arel
        mattr_accessor :predicates, default: Set.new

        def self.define_predicate(name, **options)
          predicates << name
          predicate = options.fetch(:equivalent_to, name)

          define_method(name) do |model, attribute, value|
            model.arel_table[attribute].public_send(
              predicate, format_and_sanitize_value(predicate, value, options)
            )
          end

          module_function(name)
        end

        define_predicate :in
        define_predicate :not_in
        define_predicate :equal,                 equivalent_to: :eq
        define_predicate :not_equal,             equivalent_to: :not_eq
        define_predicate :greater_than,          equivalent_to: :gt
        define_predicate :greater_than_to_equal, equivalent_to: :gteq
        define_predicate :less_than,             equivalent_to: :lt
        define_predicate :less_than_to_equal,    equivalent_to: :lteq
        define_predicate :start_with,            equivalent_to: :matches,        suffix: '%'
        define_predicate :end_with,              equivalent_to: :matches,        prefix: '%'
        define_predicate :contain,               equivalent_to: :matches,        suffix: '%', prefix: '%'
        define_predicate :not_start_with,        equivalent_to: :does_not_match, suffix: '%'
        define_predicate :not_end_with,          equivalent_to: :does_not_match, prefix: '%'
        define_predicate :not_contain,           equivalent_to: :does_not_match, suffix: '%', prefix: '%'

        def self.merge(queries, with:)
          queries.inject do |current_query, query|
            current_query.public_send(with.to_s, query)
          end
        end

        def self.not(queries)
          ::Arel::Nodes::Not.new(queries)
        end

        def self.format_and_sanitize_value(predicate, value, **options)
          case predicate
          when :in, :not_in then sanitize_sql_array(value)
          when /match/      then [options[:prefix], sanitize_sql_like(value), options[:suffix]].join
          else                   sanitize_sql(value)
          end
        end

        def self.sanitize_sql_array(value)
          [*value].map { |item| sanitize_sql(item) }
        end

        def self.sanitize_sql_like(value)
          ActiveRecord::Base.sanitize_sql_like(value)
        end

        def self.sanitize_sql(value)
          ActiveRecord::Base.sanitize_sql(value)
        end
      end
    end
  end
end
