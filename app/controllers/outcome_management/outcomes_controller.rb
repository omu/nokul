# frozen_string_literal: true

module OutcomeManagement
  class OutcomesController < ApplicationController
    include SearchableModule

    before_action :set_unit_standard
    before_action :set_outcome, except: %i[new create]

    def show; end

    def new
      @outcome = @unit_standard.outcomes.new
    end

    def edit; end

    def create
      @outcome = @unit_standard.outcomes.new(outcome_params)
      @outcome.save ? redirect_with('success') : render(:new)
    end

    def update
      @outcome.update(outcome_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @outcome.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to unit_standard_path(@unit_standard), flash: { notice: t(".#{message}") }
    end

    def set_unit_standard
      @unit_standard = UnitStandard.find(params[:unit_standard_id])
    end

    def set_outcome
      @outcome = @unit_standard.outcomes.find(params[:id])
    end

    def outcome_params
      params.require(:outcome).permit(:code, :name, :parent_id, :unit_standard_id)
    end
  end
end
