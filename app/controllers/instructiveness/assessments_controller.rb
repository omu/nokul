# frozen_string_literal: true

module Instructiveness
  class AssessmentsController < ApplicationController
    before_action :set_employee
    before_action :set_course
    before_action :set_assessment
    before_action :authorized?
    before_action :check_status, only: %i[edit update]
    before_action :check_coordinator, only: %i[save draft]

    def show
      @enrollments = @course.enrollments_under_authority_of(@employee)
    end

    def edit
      @enrollments = @course.enrollments_under_authority_of(@employee)
      @grades = @assessment.grades_under_authority_of(@employee) +
                @assessment.build_grades_for(@enrollments.where.not(id: @assessment.grades.map(&:course_enrollment_id)))
    end

    def update
      return redirect_with('success') if @assessment.update(assessment_params)

      @enrollments = @course.enrollments_under_authority_of(@employee)
      @grades = @assessment.grades.select { |grade| @enrollments.ids.include?(grade.course_enrollment_id) }
      render(:edit)
    end

    def save
      return redirect_with('not_draft_error') unless @assessment.draft?
      return redirect_with('not_full_graded_error') unless @assessment.fully_graded?

      @assessment.update(status: :saved) ? redirect_with('success') : redirect_with('error')
    end

    def draft
      return redirect_with('not_saved_error') unless @assessment.saved?

      @assessment.update(status: :draft) ? redirect_with('success') : redirect_with('error')
    end

    private

    def redirect_with(message)
      redirect_to given_course_assessment_path(@course, @assessment), flash: { info: t(".#{message}") }
    end

    def set_employee
      not_found if (@employee = current_user.current_employee).nil?
    end

    def authorized?
      authorize(@employee, policy_class: Instructiveness::AssessmentPolicy)
    end

    def set_course
      @course = @employee.given_courses.find(params[:given_course_id])
    end

    def set_assessment
      @assessment = @course.course_assessment_methods.find(params[:id])
    end

    def check_status
      redirect_with('.errors.saved') if @assessment.saved?
    end

    def check_coordinator
      redirect_with('.errors.not_coordinator') unless @employee.coordinatorships.include?(@course)
    end

    def assessment_params
      params.require(:course_assessment_method)
            .permit(grades_attributes: %i[id course_enrollment_id point])
            .merge(status: :draft)
    end
  end
end
