# frozen_string_literal: true

module Xokul
  module Yoksis
    module Resumes
      module_function

      def authors(id_number:, author_id:)
        Connection.instance.get(
          '/yoksis/resumes/authors',
          params: { id_number: id_number, author_id: author_id }
        )
      end

      %i[
        academic_duties
        academic_links
        administrative_duties
        articles
        artistic_activities
        awards
        books
        certifications
        designs
        editorships
        education_informations
        fields
        foreign_languages
        lectures
        memberships
        other_experiences
        papers
        patents
        projects
        refereeing
        thesis_advisors
      ].each do |method|
        define_method(method) do |id_number:|
          Connection.instance.get(
            "/yoksis/resumes/#{method}", params: { id_number: id_number }
          )
        end
      end

      %i[
        citations
        incentive_applications
        incentive_activity_declarations
      ].each do |method|
        define_method(method) do |id_number:, year:|
          Connection.instance.get(
            "/yoksis/resumes/#{method}", params: { id_number: id_number, year: year }
          )
        end
      end
    end
  end
end
