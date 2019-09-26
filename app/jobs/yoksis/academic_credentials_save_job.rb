# frozen_string_literal: true

module Yoksis
  class AcademicCredentialsSaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.academic_duties(id_number: user.id_number)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |credential|
        academic_credential = user.academic_credentials.find_or_initialize_by(yoksis_id: credential[:id])
        academic_credential.assign_attributes(
          yoksis_id:        credential[:id],
          activity:         credential[:activity_id],
          country_id:       Country.find_by(yoksis_code: credential[:country_id]),
          start_year:       credential[:start_date],
          end_year:         credential[:end_date],
          location:         credential[:location_id],
          scientific_field: credential[:scientific_field_name],
          status:           credential[:academic_status_id],
          title:            credential[:title_name].try(:capitalize_turkish),
          unit_name:        credential[:academic_unit_name],
          **credential.slice(
            :department, :discipline, :last_update, :profession_name, :unit_id, :university_id, :university_name
          )
        )
        academic_credential.save
      end
    end
  end
end
