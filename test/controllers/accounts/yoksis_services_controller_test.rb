# frozen_string_literal: true

require 'test_helper'

module Accounts
  class YoksisServicesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in @user
    end

    SERVICES = {
      academic_credentials:   Yoksis::AcademicCredentialsSaveJob,
      articles:               Yoksis::ArticlesSaveJob,
      books:                  Yoksis::BooksSaveJob,
      certifications:         Yoksis::CertificationsSaveJob,
      education_informations: Yoksis::EducationInformationsSaveJob,
      papers:                 Yoksis::PapersSaveJob,
      projects:               Yoksis::ProjectsSaveJob
    }.freeze

    SERVICES.each do |service, _job|
      test "should get fetch for #{service}" do
        get yoksis_services_fetch_path(service: service)
        assert_response :success
      end
    end
  end
end
