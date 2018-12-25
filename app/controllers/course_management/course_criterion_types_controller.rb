# frozen_string_literal: true

module CourseManagement
  class CourseCriterionTypesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_criterion_type, only: %i[edit update destroy]

    def index
      @criterion_types = pagy_by_search(CourseCriterionType.order(:name))
    end

    def new
      @criterion_type = CourseCriterionType.new
    end

    def create
      @criterion_type = CourseCriterionType.new(criterion_type_params)
      @criterion_type.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @criterion_type.update(criterion_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @criterion_type.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to course_criterion_types_path, flash: { notice: t(".#{message}") }
    end

    def set_criterion_type
      @criterion_type = CourseCriterionType.find(params[:id])
    end

    def criterion_type_params
      params.require(:course_criterion_type).permit(:name, :identifier)
    end
  end
end
