# frozen_string_literal: true

module Studentship
  class CourseEnrollmentsController < ApplicationController
    before_action :set_student
    before_action :set_course_enrollment, only: :destroy
    before_action :check_registrability, except: :index
    before_action :check_enrollment_status, except: %i[index list]

    def index
      @students = current_user.students.includes(:unit)
    end

    def list; end

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
      redirect_to(list_student_course_enrollments_path(@student), flash: { info: message })
    end

    private

    def redirect_with(message)
      redirect_to(new_student_course_enrollment_path(@student), flash: { info: message })
    end

    def set_student
      student = current_user.students.find(params[:student_id])
      @student = StudentDecorator.new(student)
    end

    def set_course_enrollment
      @course_enrollment = @student.course_enrollments.find(params[:id])
    end

    def check_registrability
      return if @student.registrable_for_online_course?

      redirect_to(student_course_enrollments_path(@student), alert: t('.errors.not_proper_register_event_range'))
    end

    def check_enrollment_status
      return if @student.enrollment_status != :saved

      redirect_to(student_course_enrollments_path(@student), alert: t('.errors.registration completed'))
    end

    def course_enrollment_params
      params.require(:course_enrollment).permit(:available_course_id)
    end
  end
end
