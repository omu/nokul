# frozen_string_literal: true

module Curriculum
  class CoursesController < ApplicationController
    before_action :set_course, only: %i[show edit update destroy]

    def index
      @courses = pagy_by_search(Course.includes(:unit))
    end

    def show; end

    def new
      @course = Course.new
    end

    def edit; end

    def create
      @course = Course.new(course_params)
      @course.save ? redirect_with('success') : render(:new)
    end

    def update
      @course.update(course_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @course.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to courses_path, flash: { info: t(".#{message}") }
    end

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(
        :unit_id, :name, :code, :theoric, :practice, :education_type,
        :language, :laboratory, :status
      )
    end
  end
end
