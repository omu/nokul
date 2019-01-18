# frozen_string_literal: true

module CourseManagement
  class CourseEvaluationTypesController < ApplicationController
    before_action :set_available_course
    before_action :set_course_evaluation_type, only: %i[edit update destroy]

    def new
      @evaluation_type = @available_course.evaluation_types.new
      @evaluation_type.course_assessment_methods.build
    end

    def create
      @evaluation_type = @available_course.evaluation_types.new(course_evaluation_type_params)
      @evaluation_type.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @evaluation_type.update(course_evaluation_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @evaluation_type.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to(available_course_path(@available_course), notice: t(".#{message}"))
    end

    def set_available_course
      @available_course = AvailableCourse.find(params[:available_course_id])
    end

    def set_course_evaluation_type
      @evaluation_type = @available_course.evaluation_types.find(params[:id])
    end

    def course_evaluation_type_params
      params.require(:course_evaluation_type)
            .permit(:evaluation_type_id, :percentage,
                    course_assessment_methods_attributes: %i[id assessment_method_id percentage _destroy])
    end
  end
end
