# frozen_string_literal: true

module Yoksis
  class PapersSaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.papers(id_number: user.id_number)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first

      [@response].flatten.compact.each do |paper|
        user_paper = user.papers.find_or_initialize_by(yoksis_id: paper[:publication_id])
        user_paper.assign_attributes(
          activity:                paper[:activity_id],
          authors:                 paper[:authors]&.join(', '),
          country:                 Country.find_by(yoksis_code: paper[:country_id]),
          keywords:                paper[:keywords]&.join(', '),
          language_of_publication: paper[:publication_language_name],
          presentation_type:       paper[:presentation_type_id],
          publication_status:      paper[:publication_status_id],
          scope:                   paper[:scope_id],
          special_issue:           paper[:special_issue_name],
          type:                    paper[:type_id],
          type_of_release:         paper[:type_of_release_id],
          yoksis_id:               paper[:publication_id],
          **paper.slice(
            :access_link, :author_id, :number_of_authors, :city, :discipline, :doi, :issn, :incentive_point,
            :issue, :first_page, :last_page, :last_update, :name, :print_isbn, :release_date, :sponsored_by, :volume
          )
        )
        user_paper.save
      end
    end
  end
end
