# frozen_string_literal: true

module Xokul
  module UBS
    module Statistic
      module Student
        NAMESPACE = '/ubs/api/students/statistics'

        module_function

        def by_genders_and_degree
          request("#{NAMESPACE}/genders_and_degree?locale=#{I18n.locale}")
        end

        def by_genders(schema: {})
          transform_keys(
            request("#{NAMESPACE}/genders?locale=#{I18n.locale}"), schema
          )
        end

        def by_cities(schema: {})
          transform_keys(
            request("#{NAMESPACE}/cities?locale=#{I18n.locale}"), schema
          )
        end

        def by_units
          request("#{NAMESPACE}/units?locale=#{I18n.locale}")
        end

        def non_graduates
          request("#{NAMESPACE}/non_graduates?locale=#{I18n.locale}")
        end

        def double_major_and_minor(schema: {})
          transform_keys(
            request("#{NAMESPACE}/double_major_and_minor?locale=#{I18n.locale}"), schema
          )
        end

        def transform_keys(results, schema)
          results.map { |item| item.transform_keys { |key| schema.fetch(key, key) } }
        end

        def request(path)
          response = Connection.request(path)
          response || raise(Support::RestClient::HTTPError)
        rescue Net::HTTPExceptions => e
          raise Support::RestClient::HTTPError, e
        end

        private_class_method :request
      end
    end
  end
end
