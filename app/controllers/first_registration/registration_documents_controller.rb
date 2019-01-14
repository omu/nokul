# frozen_string_literal: true

module FirstRegistration
  class RegistrationDocumentsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_registration_document, only: %i[edit update destroy]

    def index
      @registration_documents = pagy_by_search(
        RegistrationDocument.includes(
          :academic_term, :document_type, :unit
        ).order(created_at: :desc))
    end

    def new
      @registration_document = RegistrationDocument.new
    end

    def create
      @registration_document = RegistrationDocument.new(registration_document_params)
      if @registration_document.save
        redirect_to([:first_registration, 'registration_documents'], notice: t('.success'))
      else
        render(:new)
      end
    end

    def edit; end

    def update
      if @registration_document.update(registration_document_params)
        redirect_to(@unit, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      if @registration_document.destroy
        redirect_to([:first_registration, 'registration_documents'], notice: t('.success'))
      else
        redirect_to([:first_registration, 'registration_documents'], alert: t('.warning'))
      end
    end

    private

    def set_registration_document
      @registration_document = RegistrationDocument.find(params[:id])
    end

    def registration_document_params
      params.require(:registration_document).permit(:unit_id, :academic_term_id, :document_type_id)
    end
  end
end
