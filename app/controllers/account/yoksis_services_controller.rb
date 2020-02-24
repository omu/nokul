# frozen_string_literal: true

module Account
  class YoksisServicesController < ApplicationController
    SERVICES = {
      academic_credentials:   Yoksis::AcademicCredentialsSaveJob,
      articles:               Yoksis::ArticlesSaveJob,
      books:                  Yoksis::BooksSaveJob,
      certifications:         Yoksis::CertificationsSaveJob,
      education_informations: Yoksis::EducationInformationsSaveJob,
      papers:                 Yoksis::PapersSaveJob,
      projects:               Yoksis::ProjectsSaveJob
    }.freeze

    before_action :set_service

    def fetch
      authorize(@service, policy_class: Account::YoksisServicePolicy)
      @service.public_send(:perform_later, current_user)
      flash.notice = t(".#{@service_name}")
      redirect_back fallback_location: params.fetch(:redirect, root_path)
    end

    private

    def set_service
      @service_name = params.fetch(:service, '').to_sym
      return if (@service = SERVICES[@service_name])

      flash.alert = t('.service_not_found')
      redirect_back fallback_location: params.fetch(:redirect, root_path)
    end
  end
end
