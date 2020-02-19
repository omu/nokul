# frozen_string_literal: true

require 'test_helper'

module Accounts
  class YoksisServicesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    {
      academic_credentials:   Yoksis::AcademicCredentialsSaveJob,
      articles:               Yoksis::ArticlesSaveJob,
      books:                  Yoksis::BooksSaveJob,
      certifications:         Yoksis::CertificationsSaveJob,
      education_informations: Yoksis::EducationInformationsSaveJob,
      papers:                 Yoksis::PapersSaveJob,
      projects:               Yoksis::ProjectsSaveJob
    }.each do |service, _job|
      test "should get fetch for #{service}" do
        get yoksis_services_fetch_path(service: service.to_s)
        assert_response :redirect
        assert_equal t("account.yoksis_services.fetch.#{service}"), flash[:notice]
      end
    end
  end
end
