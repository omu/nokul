# frozen_string_literal: true

module Curriculum
  class CoursesController < ApplicationController
    include Pagy::Backend

    before_action :set_course, only: %i[show edit update destroy]
    before_action :add_breadcrumbs, only: %i[index show new edit]

    def index
      @courses = Course.includes(:unit).all
      @pagy, @courses = pagy(@courses)
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

    def add_breadcrumbs
      breadcrumb t('.index.courses'), courses_path, match: :exact
      case params[:action]
      when 'show'
        breadcrumb @course.name, course_path(@course), match: :exact
      when 'new', 'edit'
        breadcrumb t('.form_title'), courses_path
      end
    end
  end
end
