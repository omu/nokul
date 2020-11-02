# frozen_string_literal: true

module Xokul
  module UBS
    module Teacher
      NAMESPACE = '/ubs/api/v2/'

      module_function

      def courses(id_number, academic_term: AcademicTerm.current)
        response = Connection.request(
          "#{NAMESPACE}/teacher_with_courses?locale=#{I18n.locale}",
          params: {
            id_number: id_number,
            year:      academic_term.year.split('-').first.squish,
            semester:  academic_term.term
          }
        )

        response&.key?(:courses) ? response[:courses].map { |course| OpenStruct.new(course) } : []
      end
    end
  end
end
