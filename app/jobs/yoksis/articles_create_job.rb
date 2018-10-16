# frozen_string_literal: true

module Yoksis
  class ArticlesCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.articles(id_number: user.id_number.to_i)
    end

    # callbacks
    # rubocop:disable Metrics/BlockLength
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |article|
        user.articles.create(
          yoksis_id: article[:publishing_id],
          scope: article[:scope_id],
          review: article[:referee_type_id],
          index: article[:index_id],
          title: article[:name],
          authors: article[:authors].join(', '),
          number_of_authors: article[:number_of_author],
          country: article[:country],
          city: article[:city],
          journal: article[:journal_name],
          language_of_publication: article[:publishing_language_name],
          month: article[:month],
          year: article[:year],
          volume: article[:volume],
          issue: article[:issue],
          first_page: article[:first_page],
          last_page: article[:last_page],
          doi: article[:doi],
          issn: article[:issn],
          access_type: article[:access_type_id],
          access_link: article[:access_link],
          discipline: article[:field],
          keyword: article[:keywords],
          special_issue: article[:special_edition_id],
          special_issue_name: article[:special_edition_name],
          # sponsored_by: article[:sponsor]
          author_id: article[:author_id],
          last_update: article[:date_of_update],
          status: article[:active_or_passive_id],
          type: article[:type_id],
          incentive_point: article[:incentive_points]
        )
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
