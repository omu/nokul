# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student
  before_action :authorized?

  def edit
    @student.build_history if @student.history.nil?
  end

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
      :exceeded_education_period, :stage_id,
      history_attributes: %i[entrance_type_id registration_date registration_term_id
                             graduation_date graduation_term_id other_studentship preparatory_class]
    )
  end
end
