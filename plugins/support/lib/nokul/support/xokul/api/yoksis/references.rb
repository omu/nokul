# frozen_string_literal: true

module Xokul
  module Yoksis
    class References < API
      configure do |config|
        config.synopsis = 'Get references provided by YOKSIS'
        config.version  = '1'
      end

      def administrative_functions
        conn.get '/yoksis/references/administrative_functions'
      end

      def administrative_units
        conn.get '/yoksis/references/administrative_units'
      end

      def countries
        conn.get '/yoksis/references/countries'
      end

      def cities
        conn.get '/yoksis/references/cities'
      end

      def districts(city_code)
        conn.get '/yoksis/references/districts', params: { city_code: city_code }
      end

      def entrance_types
        conn.get '/yoksis/references/entrance_types'
      end

      def gender
        conn.get '/yoksis/references/gender'
      end

      def martyrs_relatives
        conn.get '/yoksis/references/martyrs_relatives'
      end

      def nationalities
        conn.get '/yoksis/references/nationalities'
      end

      def staff_titles
        conn.get '/yoksis/references/staff_titles'
      end

      def student_disability_types
        conn.get '/yoksis/references/student_disability_types'
      end

      def student_dropout_types
        conn.get '/yoksis/references/student_dropout_types'
      end

      def student_education_levels
        conn.get '/yoksis/references/student_education_levels'
      end

      def student_entrance_point_types
        conn.get '/yoksis/references/student_entrance_point_types'
      end

      def student_entrance_types
        conn.get '/yoksis/references/student_entrance_types'
      end

      def student_grades
        conn.get '/yoksis/references/student_grades'
      end

      def student_grading_systems
        conn.get '/yoksis/references/student_grading_systems'
      end

      def student_punishment_types
        conn.get '/yoksis/references/student_punishment_types'
      end

      def student_studentship_rights
        conn.get '/yoksis/references/student_studentship_rights'
      end

      def unit_instruction_languages
        conn.get '/yoksis/references/unit_instruction_languages'
      end

      def unit_instruction_types
        conn.get '/yoksis/references/unit_instruction_types'
      end

      def unit_statuses
        conn.get '/yoksis/references/unit_statuses'
      end

      def unit_types
        conn.get '/yoksis/references/unit_types'
      end

      def university_types
        conn.get '/yoksis/references/university_types'
      end
    end
  end
end
