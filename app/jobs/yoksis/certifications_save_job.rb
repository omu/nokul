# frozen_string_literal: true

module Yoksis
  class CertificationsSaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.certifications(id_number: user.id_number)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first

      [*@response].each do |certification|
        user_certification = user.certifications.find_or_initialize_by(yoksis_id: certification[:yoksis_id])
        user_certification.assign_attributes(
          type:   certification[:type_id],
          scope:  certification[:scope_id],
          title:  certification[:title_name].try(:capitalize_turkish),
          status: certification[:activity_id],
          **certification.slice(
            :yoksis_id, :name, :content, :location, :start_date, :end_date, :last_update,
            :incentive_point, :duration, :number_of_authors, :city_and_country
          )
        )
        user_certification.save
      end
    end
  end
end
