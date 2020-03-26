# frozen_string_literal: true

module OutcomeManagement
  class OutcomesController < ApplicationController
    include SearchableModule

    before_action :set_accreditation_standard
    before_action :set_outcome, except: %i[new create]
    before_action :authorized?

    def show; end

    def new
      @outcome = @accreditation_standard.outcomes.new
    end

    def edit; end

    def create
      @outcome = @accreditation_standard.outcomes.new(outcome_params)
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
      redirect_to accreditation_standard_path(@accreditation_standard), flash: { info: t(".#{message}") }
    end

    def set_accreditation_standard
      @accreditation_standard = AccreditationStandard.find(params[:accreditation_standard_id])
    end

    def set_outcome
      @outcome = @accreditation_standard.macro_outcomes.find(params[:id])
    end

    def authorized?
      authorize([:outcome_management, @outcome || Outcome])
    end

    def outcome_params
      params.require(:outcome).permit(
        :code, :name, :accreditation_standard_id,
        micro_outcomes_attributes: %i[id code name accreditation_standard_id _destroy]
      )
    end
  end
end
