# frozen_string_literal: true

module Yoksis
  class BooksSaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.books(id_number: user.id_number)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first

      [*@response].each do |book|
        user_book = user.books.find_or_initialize_by(yoksis_id: book[:yoksis_id])
        user_book.assign_attributes(
          activity:                book[:activity_id],
          authors:                 book[:authors]&.join(', '),
          contribution_rate:       book[:contribution_rate_id],
          country:                 Country.find_by(yoksis_code: book[:country_id]),
          keywords:                book[:keywords]&.join(', '),
          language_of_publication: book[:publication_language_name],
          scope:                   book[:scope_id],
          type:                    book[:type_id],
          type_of_release:         book[:type_of_release_id],
          **book.slice(
            :access_link, :author_id, :chapter_first_page, :chapter_last_page, :chapter_name, :city, :discipline,
            :editor_name, :incentive_point, :isbn, :last_update, :name, :number_of_authors, :number_of_copy,
            :number_of_page, :publisher, :year, :yoksis_id
          )
        )
        user_book.save
      end
    end
  end
end
