# frozen_string_literal: true

module Reference
  class StudentEducationLevelsController < ApplicationController
    include Pagy::Backend

    before_action :set_student_education_level, only: %i[show edit update destroy]

    def index
      @pagy, @student_education_levels = pagy(StudentEducationLevel.all)
    end

    def show; end

    def new
      @student_education_level = StudentEducationLevel.new
    end

    def edit; end

    def create
      @student_education_level = StudentEducationLevel.new(student_education_level_params)
      @student_education_level.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_education_level.update(student_education_level_params)
        redirect_to(@student_education_level, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_education_level.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(student_education_levels_path, notice: t(".#{message}"))
    end

    def set_student_education_level
      @student_education_level = StudentEducationLevel.find(params[:id])
    end

    def student_education_level_params
      params.require(:student_education_level).permit(:name, :code)
    end
  end
end
