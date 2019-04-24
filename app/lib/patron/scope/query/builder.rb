# frozen_string_literal: true

module Patron
  module Scope
    module Query
      class Builder
        def initialize(instance)
          @instance = instance
          @klass    = instance.class
        end

        def self.call(instance)
          new(instance).send(:build)
        end

        def self.build_for_preview(instance, records)
          builder = new(instance)
          builder.instance_variable_set(:@records, records)
          builder.send(:build)
        end

        private_class_method :new

        private

        attr_reader :instance, :klass

        def build
          queries = []

          included = prepare(records(type: :include))
          excluded = prepare(records(type: :exclude))

          queries << included                  if included.present?
          queries << Query::Arel.not(excluded) if excluded.present?

          queries.count > 1 ? Query::Arel.merge(queries, with: :and) : queries.first
        end

        def prepare(datas)
          queries = datas.map do |record|
            parameters = build_parameters(record)
            nodes      = parameters.map { |parameter| parameter.to_arel_for(klass) }

            Query::Arel.merge(nodes.compact, with: :and)
          end

          Query::Arel.merge(queries.compact, with: :or)
        end

        def build_parameters(record)
          parameters = record.parameters

          return [] if parameters.blank?

          parameters.map do |key, options|
            Query::Parameter.new(name: key, **options.symbolize_keys)
          end
        end

        def records(type: nil)
          @records ||= begin
            instance.user.query_stores.where(scope_name: klass.to_s)
          end

          return @records if type.nil?

          @records.select { |record| record.type == type.to_s }
        end
      end
    end
  end
end
