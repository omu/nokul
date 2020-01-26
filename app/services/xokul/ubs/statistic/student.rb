# frozen_string_literal: true

module Xokul
  module Ubs
    module Statistic
      module Student
        NAMESPACE = '/ubs/api/students/statistics'

        module_function

        def by_genders_and_degree
          Connection.request("#{NAMESPACE}/genders_and_degree?locale=#{I18n.locale}")
        end

        def by_genders(schema: {})
          transform_keys(
            Connection.request("#{NAMESPACE}/genders?locale=#{I18n.locale}"), schema
          )
        end

        def by_cities(schema: {})
          transform_keys(
            Connection.request("#{NAMESPACE}/cities?locale=#{I18n.locale}"), schema
          )
        end

        def by_units
          Connection.request("#{NAMESPACE}/units?locale=#{I18n.locale}")
        end

        def non_graduates
          Connection.request("#{NAMESPACE}/non_graduates?locale=#{I18n.locale}")
        end

        def double_major_and_minor(schema: {})
          transform_keys(
            Connection.request("#{NAMESPACE}/double_major_and_minor?locale=#{I18n.locale}"), schema
          )
        end

        def transform_keys(results, schema)
          results.map { |item| item.transform_keys { |key| schema.fetch(key, key) } }
        end
      end
    end
  end
end
