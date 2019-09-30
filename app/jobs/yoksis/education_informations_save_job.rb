# frozen_string_literal: true

module Yoksis
  class EducationInformationsSaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.education_informations(id_number: user.id_number)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |education|
        education_information = user.education_informations.find_or_initialize_by(yoksis_id: education[:yoksis_id])
        education_information.assign_attributes(
          activity:    education[:activity_id],
          country:     Country.find_by(yoksis_code: education[:country_id]),
          end_year:    education[:end_date],
          location:    education[:location_id],
          program:     education[:program_name],
          start_year:  education[:start_date],
          thesis_step: education[:thesis_step_id],
          unit_id:     education[:academic_unit_id],
          university:  education[:university_name],
          yoksis_id:   education[:yoksis_id],
          **education.slice(
            :advisor, :advisor_id_number, :department, :diploma_equivalency, :diploma_no, :discipline,
            :end_date_of_thesis, :faculty, :last_update, :other_discipline, :other_university,
            :start_date_of_thesis, :thesis_name
          )
        )
        education_information.save
      end
    end
  end
end
