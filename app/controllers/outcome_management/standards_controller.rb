# frozen_string_literal: true

module OutcomeManagement
  class StandardsController < ApplicationController
    include SearchableModule

    before_action :set_standard, only: %i[show edit update destroy]
    before_action :authorized?

    def index
      standards = Standard.includes(:accreditation_institution, :unit_standards, :units).where(
        params[:unit_id].present? ? { unit_standards: { unit_id: params[:unit_id] } } : {}
      )

      @pagy, @standards = pagy(standards.dynamic_search(search_params(Standard)))
    end

    def show
      @outcomes = @standard.macro_outcomes.ordered
    end

    def new
      @standard = Standard.new
    end

    def edit; end

    def create
      @standard = Standard.new(standard_params)
      @standard.save ? redirect_with('success') : render(:new)
    end

    def update
      @standard.update(standard_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @standard.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    def units
      @units = params[:term].present? ? Unit.active.faculties.search(params[:term]) : Unit.active.faculties
      respond_to :json
    end

    private

    def redirect_with(message)
      redirect_to standards_path, flash: { info: t(".#{message}") }
    end

    def set_standard
      @standard = Standard.find(params[:id])
    end

    def authorized?
      authorize([:outcome_management, @standard || Standard])
    end

    def standard_params
      params.require(:standard).permit(:accreditation_institution_id, :version, :status, unit_ids: [])
    end
  end
end
