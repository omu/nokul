# frozen_string_literal: true

module OutcomeManagement
  class OutcomesController < ApplicationController
    include SearchableModule

    before_action :set_standard
    before_action :set_outcome, except: %i[new create]
    before_action :authorized?

    def show; end

    def new
      @outcome = @standard.outcomes.new
    end

    def edit; end

    def create
      @outcome = @standard.outcomes.new(outcome_params)
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
      redirect_to standard_path(@standard), flash: { info: t(".#{message}") }
    end

    def set_standard
      @standard = Standard.find(params[:standard_id])
    end

    def set_outcome
      @outcome = @standard.macro_outcomes.find(params[:id])
    end

    def authorized?
      authorize([:outcome_management, @outcome || Outcome])
    end

    def outcome_params
      params.require(:outcome).permit(
        :code, :name, :standard_id,
        micro_outcomes_attributes: %i[id code name standard_id _destroy]
      )
    end
  end
end
