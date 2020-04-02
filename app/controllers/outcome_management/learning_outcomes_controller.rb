# frozen_string_literal: true

module OutcomeManagement
  class LearningOutcomesController < ApplicationController
    include SearchableModule

    before_action :set_accreditation_standard
    before_action :set_learning_outcome, except: %i[new create]
    before_action :authorized?

    def show; end

    def new
      @learning_outcome = @accreditation_standard.learning_outcomes.new
    end

    def edit; end

    def create
      @learning_outcome = @accreditation_standard.learning_outcomes.new(learning_outcome_params)
      @learning_outcome.save ? redirect_with('success') : render(:new)
    end

    def update
      @learning_outcome.update(learning_outcome_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @learning_outcome.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to accreditation_standard_path(@accreditation_standard), flash: { info: t(".#{message}") }
    end

    def set_accreditation_standard
      @accreditation_standard = AccreditationStandard.find(params[:accreditation_standard_id])
    end

    def set_learning_outcome
      @learning_outcome = @accreditation_standard.macro_learning_outcomes.find(params[:id])
    end

    def authorized?
      authorize([:outcome_management, @learning_outcome || LearningOutcome])
    end

    def learning_outcome_params
      params.require(:learning_outcome).permit(
        :code, :name, :accreditation_standard_id,
        micros_attributes: %i[id code name accreditation_standard_id _destroy]
      )
    end
  end
end
