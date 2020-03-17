# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student
  before_action :authorized?

  def edit; end

  def update
    @student.update(student_params) ? redirect_to(user_path(@student.user), notice: t('.success')) : render(:edit)
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def authorized?
    authorize(@student || Student)
  end

  def student_params
    params.require(:student).permit(
      :student_number, :unit_id, :year, :semester, :scholarship_type_id, :status,
      :exceeded_education_period, :stage_id
    )
  end
end
