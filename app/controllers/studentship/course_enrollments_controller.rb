# frozen_string_literal: true

module Studentship
  class CourseEnrollmentsController < ApplicationController
    before_action :set_student
    before_action :authorized?
    before_action :set_service, except: :index
    before_action :set_course_enrollment, only: :destroy
    before_action :event_active?, except: :index
    before_action :check_registration_status, except: %i[index list]

    def index
      @students = current_user.students.includes(:unit)
    end

    def list; end

    def new
      @service.build_catalog
    end

    def create
      message = @service.enroll(course_enrollment_params) ? t('.success') : t('.error')
      redirect_with(message)
    rescue StudentCourseEnrollmentService::EnrollableError => e
      redirect_with(e.message)
    end

    def destroy
      message = @service.drop(@course_enrollment) ? t('.success') : t('.error')
      redirect_with(message)
    rescue StudentCourseEnrollmentService::EnrollableError => e
      redirect_with(e.message)
    end

    def save
      return redirect_with(t('.errors.empty_selected_courses_list')) if @service.course_enrollments.empty?
      return redirect_with(t('.error')) unless @service.save

      redirect_to(list_student_course_enrollments_path(@student), flash: { info: t('.success') })
    end

    private

    def redirect_with(message)
      redirect_to(new_student_course_enrollment_path(@student), flash: { info: message })
    end

    def set_student
      student = current_user.students.find(params[:student_id])
      @student = StudentDecorator.new(student)
    end

    def set_service
      @service = StudentCourseEnrollmentService.new(@student)
    end

    def set_course_enrollment
      @course_enrollment = @student.current_registration.course_enrollments.find(params[:id])
    end

    def authorized?
      authorize(@student, policy_class: Studentship::CourseEnrollmentPolicy)
    end

    def event_active?
      return if @student.event_online_course_registrations&.active_now?

      redirect_to(student_course_enrollments_path(@student), alert: t('.errors.not_proper_register_event_range'))
    end

    def check_registration_status
      return if @student.current_registration.draft?

      redirect_to(student_course_enrollments_path(@student), alert: t('.errors.registration_completed'))
    end

    def course_enrollment_params
      params.require(:course_enrollment).permit(:available_course_id, :available_course_group_id)
    end
  end
end
