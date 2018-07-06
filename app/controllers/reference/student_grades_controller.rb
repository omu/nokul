# frozen_string_literal: true

module Reference
  class StudentGradesController < ApplicationController
    include Pagy::Backend

    before_action :set_student_grade, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @student_grades = pagy(StudentGrade.all)
    end

    def show
      breadcrumb @student_grade.name, student_grade_path
    end

    def new
      breadcrumb t('.form_title'), new_student_grade_path
      @student_grade = StudentGrade.new
    end

    def edit
      breadcrumb t('.form_title'), edit_student_grade_path
    end

    def create
      @student_grade = StudentGrade.new(student_grade_params)
      @student_grade.save ? redirect_with('success') : render(:new)
    end

    def update
      if @student_grade.update(student_grade_params)
        redirect_to(@student_grade, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @student_grade.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), student_grades_path, match: :exact
    end

    def redirect_with(message)
      redirect_to(student_grades_path, notice: t(".#{message}"))
    end

    def set_student_grade
      @student_grade = StudentGrade.find(params[:id])
    end

    def student_grade_params
      params.require(:student_grade).permit(:name, :code)
    end
  end
end
