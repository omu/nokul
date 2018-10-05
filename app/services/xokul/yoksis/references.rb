# frozen_string_literal: true

module Xokul
  module Yoksis
    module References
      module_function

      def districts(city_code:)
        Connection.instance.get(
          '/yoksis/references/districts', params: { city_code: city_code }
        )
      end

      %i[
        administrative_functions
        administrative_units
        cities
        countries
        entrance_types
        gender
        kod_bid
        martyrs_relatives
        nationalities
        staff_titles
        student_disability_types
        student_dropout_types
        student_education_levels
        student_entrance_point_types
        student_entrance_types
        student_grades
        student_grading_systems
        studentship_rights
        studentship_statuses
        unit_instruction_languages
        unit_instruction_types
        unit_statuses
        unit_types
        university_types
      ].each do |method|
        define_method(method) do
          Connection.instance.get "/yoksis/references/#{method}"
        end
      end
    end
  end
end
