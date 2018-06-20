# frozen_string_literal: true

module Curriculum
  class CoursesController < ApplicationController
    include Pagy::Backend

    before_action :set_course, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @courses = Course.includes(:unit).all
      @pagy, @courses = pagy(@courses)
    end

    def show
      breadcrumb @course.name, course_path(@course), match: :exact
    end

    def new
      breadcrumb 'Yeni Ders Ekle', new_course_path, match: :exact
      @course = Course.new
    end

    def edit
      breadcrumb "#{@course.name} - Düzenle", edit_course_path(@course), match: :exact
    end

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

    def set_root_breadcrumb
      breadcrumb 'Dersler', courses_path, match: :exact
    end

    def course_params
      params.require(:course).permit(
        :unit_id, :name, :code, :theoric, :practice, :education_type,
        :language, :laboratory, :status
      )
    end
  end
end
