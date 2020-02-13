# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student

  def edit; end

  def update
    @student.update(student_params) ? redirect_to(user_path(@student.user), notice: t('.success')) : render(:edit)
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:student_number, :unit_id, :year, :semester, :scholarship_type_id)
  end
end
