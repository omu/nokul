# frozen_string_literal: true

module Yoksis
  class ArticlesCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.articles(id_number: user.id_number.to_i)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |article|
        user.articles.create(
          yoksis_id: article[:publication_id],
          scope: article[:scope_id],
          review: article[:reviewer_id],
          index: article[:index_id],
          title: article[:name],
          authors: article[:authors].join(', '),
          country: article[:country_id],
          journal: article[:journal_name],
          language_of_publication: article[:publication_language_name],
          access_type: article[:access_type_id],
          keyword: article[:keywords],
          special_issue: article[:special_issue_id],
          status: article[:activity_id],
          type: article[:type_id],
          **article.slice(
            :city, :month, :year, :volume, :issue, :first_page, :last_page,
            :doi, :issn, :access_link, :discipline, :special_issue_name, :author_id,
            :last_update, :incentive_point, :sponsored_by, :number_of_authors
          )
        )
      end
    end
  end
end
