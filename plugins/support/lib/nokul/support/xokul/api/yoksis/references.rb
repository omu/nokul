# frozen_string_literal: true

module Xokul
  module Yoksis
    class References < Endpoint
      configure do |config|
        config.synopsis         = 'Get references provided by YOKSIS'
        config.namespace        = '/yoksis/references'
        config.upstream_version = '1'
      end

      def administrative_functions
        conn.get :administrative_functions
      end

      def administrative_units
        conn.get :administrative_units
      end

      def countries
        conn.get :countries
      end

      def cities
        conn.get :cities
      end

      def districts(city_code)
        conn.get :districts, params: { city_code: city_code }
      end

      def entrance_types
        conn.get :entrance_types
      end

      def gender
        conn.get :gender
      end

      def martyrs_relatives
        conn.get :martyrs_relatives
      end

      def nationalities
        conn.get :nationalities
      end

      def staff_titles
        conn.get :staff_titles
      end

      def student_disability_types
        conn.get :student_disability_types
      end

      def student_dropout_types
        conn.get :student_dropout_types
      end

      def student_education_levels
        conn.get :student_education_levels
      end

      def student_entrance_point_types
        conn.get :student_entrance_point_types
      end

      def student_entrance_types
        conn.get :student_entrance_types
      end

      def student_grades
        conn.get :student_grades
      end

      def student_grading_systems
        conn.get :student_grading_systems
      end

      def student_punishment_types
        conn.get :student_punishment_types
      end

      def student_studentship_rights
        conn.get :student_studentship_rights
      end

      def unit_instruction_languages
        conn.get :unit_instruction_languages
      end

      def unit_instruction_types
        conn.get :unit_instruction_types
      end

      def unit_statuses
        conn.get :unit_statuses
      end

      def unit_types
        conn.get :unit_types
      end

      def university_types
        conn.get :university_types
      end
    end
  end
end
