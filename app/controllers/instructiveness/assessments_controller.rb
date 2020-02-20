# frozen_string_literal: true

module Instructiveness
  class AssessmentsController < ApplicationController
    before_action :set_employee
    before_action :set_course
    before_action :set_assessment

    def edit
      @grades = @assessment.grades_under_authority_of_(@employee)
      enrollments = @course.enrollments_under_authority_of(@employee)
                           .where.not(id: @grades.map(&:course_enrollment_id))
      @grades += @assessment.grades.build(enrollments.collect { |e| { course_enrollment_id: e.id } })
    end

    def update
      if @assessment.update(assessment_params)
        @assessment.update(status: :draft) unless @assessment.draft?
        redirect_with('success')
      else
        render(:edit)
      end
    end

    private

    def redirect_with(message)
      redirect_to edit_given_course_assessment_path(@course, @assessment), flash: { info: t(".#{message}") }
    end

    def set_employee
      not_found if (@employee = current_user.current_employee).nil?
    end

    def set_course
      @course = @employee.given_courses.find(params[:given_course_id])
    end

    def set_assessment
      @assessment = @course.course_assessment_methods.find(params[:id])
    end

    def assessment_params
      params.require(:course_assessment_method)
            .permit(grades_attributes: %i[id course_assessment_method_id course_enrollment_id point])
    end
  end
end
