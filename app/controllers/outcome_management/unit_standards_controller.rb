# frozen_string_literal: true

module OutcomeManagement
  class UnitStandardsController < ApplicationController
    include SearchableModule

    before_action :set_unit_standard, only: %i[show edit update destroy]
    before_action :authorized?

    def index
      unit_standards = UnitStandard.includes(:standard, :unit)
      @pagy, @unit_standards = pagy(unit_standards)
    end

    def show
      @unit = @unit_standard.unit
      @outcomes = @unit_standard.macro_outcomes.ordered
    end

    def new
      @unit_standard = UnitStandard.new
    end

    def edit; end

    def create
      @unit_standard = UnitStandard.new(unit_standard_params)
      @unit_standard.save ? redirect_with('success') : render(:new)
    end

    def update
      @unit_standard.update(unit_standard_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @unit_standard.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to unit_standards_path, flash: { notice: t(".#{message}") }
    end

    def set_unit_standard
      @unit_standard = UnitStandard.find(params[:id])
    end

    def authorized?
      authorize([:outcome_management, @unit_standard || UnitStandard])
    end

    def unit_standard_params
      params.require(:unit_standard).permit(:unit_id, :standard_id, :status)
    end
  end
end
