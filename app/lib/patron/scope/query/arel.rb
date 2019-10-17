# frozen_string_literal: true

module Patron
  module Scope
    module Query
      module Arel
        mattr_accessor :predicates, default: {}

        def self.define_predicate(name, **options)
          predicates[name] = options
          predicate        = options.fetch(:equivalent_to, name)

          define_singleton_method(name) do |model, attribute, value|
            model.arel_table[attribute].public_send(
              predicate,
              format(sanitize(predicate, value),
                     options.slice(:prefix, :suffix))
            )
          end
        end

        define_predicate :in,
                         scope: :array
        define_predicate :not_in,
                         scope: :array
        define_predicate :equal,
                         equivalent_to: :eq,
                         scope:         :string
        define_predicate :not_equal,
                         equivalent_to: :not_eq,
                         scope:         :string
        define_predicate :greater_than,
                         equivalent_to: :gt,
                         scope:         :string
        define_predicate :greater_than_to_equal,
                         equivalent_to: :gteq,
                         scope:         :string
        define_predicate :less_than,
                         equivalent_to: :lt,
                         scope:         :string
        define_predicate :less_than_to_equal,
                         equivalent_to: :lteq,
                         scope:         :string
        define_predicate :start_with,
                         equivalent_to: :matches,
                         suffix:        '%',
                         scope:         %i[string like]
        define_predicate :not_start_with,
                         equivalent_to: :does_not_match,
                         suffix:        '%',
                         scope:         %i[string like]
        define_predicate :end_with,
                         equivalent_to: :matches,
                         prefix:        '%',
                         scope:         %i[string like]
        define_predicate :not_end_with,
                         equivalent_to: :does_not_match,
                         prefix:        '%',
                         scope:         %i[string like]
        define_predicate :contain,
                         equivalent_to: :matches,
                         prefix:        '%',
                         suffix:        '%',
                         scope:         %i[string like]
        define_predicate :not_contain,
                         equivalent_to: :does_not_match,
                         prefix:        '%',
                         suffix:        '%',
                         scope:         %i[string like]

        def self.merge(queries, with:)
          queries.inject do |current_query, query|
            current_query.public_send(with.to_s, query)
          end
        end

        def self.not(queries)
          ::Arel::Nodes::Not.new(queries) if queries.present?
        end

        def self.sanitize(predicate, value)
          case predicate
          when *predicates_for_array    then sanitize_sql_array(value)
          when *predicates_for_sql_like then ActiveRecord::Base.sanitize_sql_like(value)
          else                               ActiveRecord::Base.sanitize_sql(value)
          end
        end

        def self.format(values, prefix: nil, suffix: nil)
          return values.map { |v| "#{prefix}#{v}#{suffix}" } if values.is_a? Array

          "#{prefix}#{values}#{suffix}"
        end

        def self.sanitize_sql_array(value)
          [*value].map { |item| ActiveRecord::Base.sanitize_sql(item) }
        end

        def self.predicates_for_array
          filter_predicates_by_scope(:array).keys
        end

        def self.predicates_for_string
          filter_predicates_by_scope(:string).keys
        end

        def self.predicates_for_sql_like
          filter_predicates_by_scope(:like).keys
        end

        def self.filter_predicates_by_scope(*scope)
          predicates.select do |_, options|
            scope.any? { |item| [*options[:scope]].include?(item) }
          end
        end
      end
    end
  end
end
