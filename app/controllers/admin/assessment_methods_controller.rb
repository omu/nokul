# frozen_string_literal: true

module Admin
  class AssessmentMethodsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_assessment_method, only: %i[edit update destroy]

    def index
      @assessment_methods = pagy_by_search(AssessmentMethod.order(:name))
    end

    def new
      @assessment_method = AssessmentMethod.new
    end

    def edit; end

    def create
      @assessment_method = AssessmentMethod.new(assessment_method_params)
      @assessment_method.save ? index_path('success') : render(:new)
    end

    def update
      @assessment_method.update(assessment_method_params) ? index_path('success') : render(:edit)
    end

    def destroy
      @assessment_method.destroy ? index_path('success') : index_path('warning')
    end

    private

    def index_path(message)
      redirect_to(%i[admin assessment_methods], notice: t(".#{message}"))
    end

    def set_assessment_method
      @assessment_method = AssessmentMethod.find(params[:id])
    end

    def assessment_method_params
      params.require(:assessment_method).permit(:name)
    end
  end
end
