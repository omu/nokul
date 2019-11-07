# frozen_string_literal: true

module Studentship
  class CourseEnrollmentsController < ApplicationController
    before_action :set_student, only: %i[new create destroy save]
    before_action :set_course_enrollment, only: :destroy

    def index
      @students = current_user.students.includes(:unit)
    end

    def new; end

    def create
      message = @student.course_enrollments.new(course_enrollment_params).save ? t('.success') : t('.error')
      redirect_with(message)
    end

    def destroy
      message = @course_enrollment.destroy ? t('.success') : t('.error')
      redirect_with(message)
    end

    def save
      message = @student.semester_enrollments.update(status: :saved) ? t('.success') : t('.error')
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to(new_course_enrollment_path, flash: { info: message })
    end

    def set_student
      student =
        current_user.students.find_by(id: params[:student_id]) ||
        current_user.students.first

      redirect_to(:root, alert: t('.student_record_not_found')) unless student

      @student = StudentDecorator.new(student)
    end

    def set_course_enrollment
      @course_enrollment = @student.course_enrollments.find(params[:id])
    end

    def course_enrollment_params
      params.require(:course_enrollment).permit(:available_course_id)
    end
  end
end
