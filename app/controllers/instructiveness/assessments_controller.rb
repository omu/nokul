# frozen_string_literal: true

module Instructiveness
  class AssessmentsController < ApplicationController
    before_action :set_employee
    before_action :set_course
    before_action :set_assessment
    before_action :authorized?

    def edit
      @grades = @assessment.grades_under_authority_of(@employee)
      enrollments = @course.enrollments_under_authority_of(@employee).where.not(id: @grades.map(&:course_enrollment_id))
      @grades += @assessment.build_grades_for(enrollments)
    end

    def update
      @assessment.update(assessment_params) ? redirect_with('success') : render(:edit)
    end

    private

    def redirect_with(message)
      redirect_to edit_given_course_assessment_path(@course, @assessment), flash: { info: t(".#{message}") }
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

    def assessment_params
      params.require(:course_assessment_method)
            .permit(grades_attributes: %i[id course_enrollment_id point])
            .merge(status: :draft)
    end
  end
end
