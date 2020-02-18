# frozen_string_literal: true

module Instructiveness
  class GradesController < ApplicationController
    before_action :set_employee
    before_action :set_course
    before_action :set_groups
    before_action :set_assessment

    def edit
      enrollments = @course.saved_enrollments
                           .where(available_course_group: @groups)
                           .where.not(id: @assessment.grades.pluck(:course_enrollment_id))

      return if enrollments.empty?

      @assessment.grades.create(enrollments.collect { |e| { course_enrollment_id: e.id } })
    end

    def update
      @grades = @assessment.grades.update(grades_params.keys, grades_params.values)
      @grades.reject! { |g| g.errors.empty? }

      if @grades.empty?
        @assessment.update(status: :draft) unless @assessment.draft?
        redirect_with('success')
      else
        render :edit
      end
    end

    private

    def redirect_with(message)
      redirect_to(edit_given_course_assessment_grades_path(@course, @assessment), flash: { info: t(".#{message}") })
    end

    def set_employee
      not_found if (@employee = current_user.current_employee).nil?
    end

    def set_course
      @course = @employee.given_courses.find(params[:given_course_id])
    end

    def set_groups
      @groups = @employee.given_course_groups_of(@course)
    end

    def set_assessment
      @assessment = @course.course_assessment_methods.find(params[:assessment_id])
    end

    def grades_params
      params.require(:grades)
    end
  end
end
