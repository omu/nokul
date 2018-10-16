# frozen_string_literal: true

module Yoksis
  class CertificationsCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.certifications(id_number: user.id_number.to_i)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |study|
        user.certifications.create(
          yoksis_id: study[:registry_id],
          type: study[:type_id],
          name: study[:name],
          content: study[:content],
          location: study[:place],
          scope: study[:scope_id],
          duration: study[:stint],
          start_date: study[:date_of_start],
          end_date: study[:date_of_end],
          title: study[:title_name].try(:capitalize_all),
          number_of_authors: study[:number_of_person],
          city_and_country: "#{study[:country]}/#{study[:city]}",
          last_update: study[:date_of_update],
          incentive_point: study[:incentive_point],
          status: study[:active_or_passive_id]
        )
      end
    end
  end
end
