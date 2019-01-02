# frozen_string_literal: true

module Yoksis
  class CertificationsCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.certifications(id_number: user.id_number)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |certification|
        user.certifications.create(
          type: certification[:type_id],
          scope: certification[:scope_id],
          title: certification[:title_name].try(:capitalize_turkish),
          status: certification[:activity_id],
          **certification.slice(
            :yoksis_id, :name, :content, :location, :start_date, :end_date, :last_update,
            :incentive_point, :duration, :number_of_authors, :city_and_country
          )
        )
      end
    end
  end
end
