# frozen_string_literal: true

module OutcomeManagement
  class AccreditationStandardsController < ApplicationController
    include SearchableModule

    before_action :set_accreditation_standard, only: %i[show edit update destroy]
    before_action :authorized?

    def index
      standards = AccreditationStandard.includes(:accreditation_institution, :unit_standards, :units).where(
        params[:unit_id].present? ? { unit_standards: { unit_id: params[:unit_id] } } : {}
      )

      @pagy, @accreditation_standards = pagy(standards.dynamic_search(search_params(AccreditationStandard)))
    end

    def show
      @outcomes = @accreditation_standard.macro_outcomes.ordered
    end

    def new
      @accreditation_standard = AccreditationStandard.new
    end

    def edit; end

    def create
      @accreditation_standard = AccreditationStandard.new(accreditation_standard_params)
      @accreditation_standard.save ? redirect_with('success') : render(:new)
    end

    def update
      @accreditation_standard.update(accreditation_standard_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @accreditation_standard.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    def units
      @units = params[:term].present? ? Unit.active.faculties.search(params[:term]) : Unit.active.faculties
      respond_to :json
    end

    private

    def redirect_with(message)
      redirect_to accreditation_standards_path, flash: { info: t(".#{message}") }
    end

    def set_accreditation_standard
      @accreditation_standard = AccreditationStandard.find(params[:id])
    end

    def authorized?
      authorize([:outcome_management, @accreditation_standard || AccreditationStandard])
    end

    def accreditation_standard_params
      params.require(:accreditation_standard).permit(:accreditation_institution_id, :version, :status, unit_ids: [])
    end
  end
end
