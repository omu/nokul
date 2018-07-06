# frozen_string_literal: true

module Reference
  class StudentEducationLevelsController < ApplicationController
    include Pagy::Backend

    before_action :set_student_education_level, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @student_education_levels = pagy(StudentEducationLevel.all)
    end

    def show
      breadcrumb @student_education_level.name, student_education_level_path
    end

    def new
      breadcrumb t('.form_title'), new_student_education_level_path
      @student_education_level = StudentEducationLevel.new
    end

    def edit
      breadcrumb t('.form_title'), edit_student_education_level_path
    end

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

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), student_education_levels_path, match: :exact
    end

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
