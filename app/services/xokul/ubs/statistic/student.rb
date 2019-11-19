# frozen_string_literal: true

module Xokul
  module Ubs
    module Statistic
      module Student
        NAMESPACE = '/ubs/api/students/statistics'

        module_function

        def by_genders_and_degree
          Connection.request("#{NAMESPACE}/genders_and_degree")
        end

        def by_genders
          Connection.request("#{NAMESPACE}/genders")
        end

        def by_cities
          Connection.request("#{NAMESPACE}/cities")
        end

        def by_units
          Connection.request("#{NAMESPACE}/units")
        end

        def non_graduates
          Connection.request("#{NAMESPACE}/non_graduates")
        end

        def double_major_and_minor
          Connection.request("#{NAMESPACE}/double_major_and_minor")
        end
      end
    end
  end
end
