# frozen_string_literal: true

module References
  class EvaluationTypesController < ApplicationController
    before_action :set_evaluation_type, only: %i[edit update destroy]

    def index
      @evaluation_types = EvaluationType.order(:name)
    end

    def new
      @evaluation_type = EvaluationType.new
    end

    def edit; end

    def create
      @evaluation_type = EvaluationType.new(evaluation_type_params)
      @evaluation_type.save ? redirect_with('success') : render(:new)
    end

    def update
      @evaluation_type.update(evaluation_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @evaluation_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(:evaluation_types, notice: t(".#{message}"))
    end

    def set_evaluation_type
      @evaluation_type = EvaluationType.find(params[:id])
    end

    def evaluation_type_params
      params.require(:evaluation_type).permit(:name)
    end
  end
end
