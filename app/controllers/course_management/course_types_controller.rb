# frozen_string_literal: true

module CourseManagement
  class CourseTypesController < ApplicationController
    include SearchableModule

    before_action :set_course_type, only: %i[edit update destroy]

    def index
      @course_types = pagy_by_search(CourseType.order(:name))
    end

    def new
      @course_type = CourseType.new
    end

    def create
      @course_type = CourseType.new(course_type_params)
      @course_type.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @course_type.update(course_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @course_type.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to(course_types_path, notice: t(".#{message}"))
    end

    def set_course_type
      @course_type = CourseType.find(params[:id])
    end

    def course_type_params
      params.require(:course_type).permit(:name, :code, :min_credit)
    end
  end
end
