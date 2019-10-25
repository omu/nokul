# frozen_string_literal: true

module Studentship
  class CourseEnrollmentsController < ApplicationController
    before_action :set_student, only: %i[new create destroy save]
    before_action :set_course_enrollment, only: :destroy

    def index
      @students = current_user.students.includes(:unit)
    end

    def new; end

    # TODO
    def create
      @student.course_enrollments.create(available_course_id: params[:available_course_id], semester: @student.semester)
      redirect_to new_course_enrollment_path
    end

    # TODO
    def destroy
      @course_enrollment.destroy
      redirect_to new_course_enrollment_path
    end

    def save
      @student.semester_enrollments.update(status: :saved)
      redirect_to new_course_enrollment_path
    end

    private

    def redirect_with(message)
      redirect_to(:root, alert: t(".#{message}"))
    end

    def set_student
      student =
        current_user.students.find_by(id: params[:student_id]) ||
        current_user.students.first

      redirect_with('student_record_not_found') unless student

      @student = StudentDecorator.new(student)
    end

    def set_course_enrollment
      @course_enrollment = @student.course_enrollments.find(params[:id])
    end
  end
end
