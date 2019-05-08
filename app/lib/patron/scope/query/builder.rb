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

          queries << prepare(records(type: :include))
          queries << Query::Arel.not(prepare(records(type: :exclude)))

          Query::Arel.merge(queries.compact, with: :and)
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
          @records ||= instance.user.query_stores.active.where(scope_name: klass.to_s)

          return @records unless type

          @records.select { |record| record.type == type.to_s }
        end
      end
    end
  end
end
