# frozen_string_literal: true

module Xokul
  module Yoksis
    class Resumes < Endpoint
      configure do |config|
        config.synopsis  = "Get someone's academic history from YOKSIS"
        config.version   = '1'
        config.namespace = '/yoksis/resumes'
      end

      def academic_duties(id_number)
        conn.get '/academic_duties', params: { id_number: id_number }
      end

      def academic_links(id_number)
        conn.get '/academic_links', params: { id_number: id_number }
      end

      def administrative_duties(id_number)
        conn.get '/administrative_duties', params: { id_number: id_number }
      end

      def articles(id_number)
        conn.get '/articles', params: { id_number: id_number }
      end

      def artistic_activities(id_number)
        conn.get '/artistic_activities', params: { id_number: id_number }
      end

      def authors(id_number, author_id)
        conn.get '/authors', params: { id_number: id_number, author_id: author_id }
      end

      def awards(id_number)
        conn.get '/awards', params: { id_number: id_number }
      end

      def books(id_number)
        conn.get '/books', params: { id_number: id_number }
      end

      def certifications(id_number)
        conn.get '/certifications', params: { id_number: id_number }
      end

      def citations(id_number, year)
        conn.get '/citations', params: { id_number: id_number, year: year }
      end

      def designs(id_number)
        conn.get '/designs', params: { id_number: id_number }
      end

      def editorships(id_number)
        conn.get '/editorships', params: { id_number: id_number }
      end

      def education_information(id_number)
        conn.get '/education_information', params: { id_number: id_number }
      end

      def fields(id_number)
        conn.get '/fields', params: { id_number: id_number }
      end

      def foreign_languages(id_number)
        conn.get '/foreign_languages', params: { id_number: id_number }
      end

      def incentive_applications(id_number, year)
        conn.get '/incentive_applications', params: { id_number: id_number, year: year }
      end

      def incentive_activity_declarations(id_number, year)
        conn.get '/incentive_activity_declarations', params: { id_number: id_number, year: year }
      end

      def lectures(id_number)
        conn.get '/lectures', params: { id_number: id_number }
      end

      def memberships(id_number)
        conn.get '/memberships', params: { id_number: id_number }
      end

      def other_experiences(id_number)
        conn.get '/other_experiences', params: { id_number: id_number }
      end

      def papers(id_number)
        conn.get '/papers', params: { id_number: id_number }
      end

      def patents(id_number)
        conn.get '/patents', params: { id_number: id_number }
      end

      def projects(id_number)
        conn.get '/projects', params: { id_number: id_number }
      end

      def refereeing(id_number)
        conn.get '/refereeing', params: { id_number: id_number }
      end

      def thesis_advisors(id_number)
        conn.get '/thesis_advisors', params: { id_number: id_number }
      end
    end
  end
end
