# frozen_string_literal: true

module Xokul
  module Yoksis
    module Resumes
      module_function

      def academic_duties(id_number:)
        Connection.instance.get "/yoksis/resumes/#{__callee__}", params: { id_number: id_number }
      end

      def authors(author_id:)
        Connection.instance.get '/yoksis/resumes/authors', params: { author_id: author_id }
      end

      def citations(id_number:, year:)
        Connection.instance.get '/yoksis/resumes/citations', params: { id_number: id_number, year: year }
      end

      class << self
        alias academic_links                  academic_duties
        alias administrative_duties           academic_duties
        alias articles                        academic_duties
        alias artistic_activities             academic_duties
        alias awards                          academic_duties
        alias books                           academic_duties
        alias certifications                  academic_duties
        alias designs                         academic_duties
        alias editorships                     academic_duties
        alias education_informations          academic_duties
        alias fields                          academic_duties
        alias foreign_languages               academic_duties
        alias lectures                        academic_duties
        alias memberships                     academic_duties
        alias other_experiences               academic_duties
        alias papers                          academic_duties
        alias patents                         academic_duties
        alias projects                        academic_duties
        alias refereeing                      academic_duties
        alias thesis_advisors                 academic_duties
        alias incentive_applications          citations
        alias incentive_activity_declarations citations
      end
    end
  end
end
