# frozen_string_literal: true

module Admin
  class EvaluationTypesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_evaluation_type, only: %i[edit update destroy]

    def index
      @evaluation_types = pagy_by_search(EvaluationType.order(:name))
    end

    def new
      @evaluation_type = EvaluationType.new
    end

    def edit; end

    def create
      @evaluation_type = EvaluationType.new(evaluation_type_params)
      @evaluation_type.save ? index_path('success') : render(:new)
    end

    def update
      @evaluation_type.update(evaluation_type_params) ? index_path('success') : render(:edit)
    end

    def destroy
      @evaluation_type.destroy ? index_path('success') : index_path('warning')
    end

    private

    def index_path(message)
      redirect_to(%i[admin evaluation_types], notice: t(".#{message}"))
    end

    def set_evaluation_type
      @evaluation_type = EvaluationType.find(params[:id])
    end

    def evaluation_type_params
      params.require(:evaluation_type).permit(:name)
    end
  end
end
