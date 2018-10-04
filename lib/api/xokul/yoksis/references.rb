# frozen_string_literal: true

module Xokul
  module Yoksis
    module References
      module_function

      def administrative_functions
        Connection.instance.get "/yoksis/references/#{__callee__}"
      end

      def districts(city_code:)
        Connection.instance.get '/yoksis/references/districts', params: { city_code: city_code }
      end

      class << self
        alias administrative_units         administrative_functions
        alias cities                       administrative_functions
        alias countries                    administrative_functions
        alias entrance_types               administrative_functions
        alias gender                       administrative_functions
        alias kod_bid                      administrative_functions
        alias martyrs_relatives            administrative_functions
        alias nationalities                administrative_functions
        alias staff_titles                 administrative_functions
        alias student_disability_types     administrative_functions
        alias student_dropout_types        administrative_functions
        alias student_education_levels     administrative_functions
        alias student_entrance_point_types administrative_functions
        alias student_entrance_types       administrative_functions
        alias student_grades               administrative_functions
        alias student_grading_systems      administrative_functions
        alias studentship_rights           administrative_functions
        alias studentship_statuses         administrative_functions
        alias unit_instruction_languages   administrative_functions
        alias unit_instruction_types       administrative_functions
        alias unit_statuses                administrative_functions
        alias unit_types                   administrative_functions
        alias university_types             administrative_functions
      end
    end
  end
end
