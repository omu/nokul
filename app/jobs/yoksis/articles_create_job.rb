# frozen_string_literal: true

module Yoksis
  class ArticlesCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.articles(id_number: user.id_number)
    end

    # rubocop:disable Metrics/BlockLength
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |article|
        user_article = user.articles.find_or_initialize_by(yoksis_id: article[:publication_id])
        user_article.assign_attributes(
          yoksis_id:               article[:publication_id],
          scope:                   article[:scope_id],
          review:                  article[:reviewer_id],
          index:                   article[:index_id],
          title:                   article[:name],
          authors:                 article[:authors].join(', '),
          country:                 article[:country_id],
          journal:                 article[:journal_name],
          language_of_publication: article[:publication_language_name],
          access_type:             article[:access_type_id],
          keyword:                 article[:keywords],
          special_issue:           article[:special_issue_id],
          status:                  article[:activity_id],
          type:                    article[:type_id],
          **article.slice(
            :city, :month, :year, :volume, :issue, :first_page, :last_page,
            :doi, :issn, :access_link, :discipline, :special_issue_name, :author_id,
            :last_update, :incentive_point, :sponsored_by, :number_of_authors
          )
        )
        user_article.save
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
