# frozen_string_literal: true

module Instructiveness
  class GradesController < ApplicationController
    before_action :set_employee
    before_action :set_course
    before_action :set_groups
    before_action :set_assessment

    def edit; end

    def update
      @course.saved_enrollments.each do |enrollment|
        new_point = grades_params[enrollment.id.to_s]
        grade = enrollment.grades.find_or_initialize_by(course_assessment_method: @assessment)
        grade.update(point: new_point) if grade.point != new_point
      end

      @assessment.update(status: :draft) ? redirect_with('success') : render(:edit)
    end

    private

    def redirect_with(message)
      redirect_to(edit_given_course_assessment_grades_path(@course, @assessment), flash: { info: message })
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
      params.require(:course_enrollment_grades)
    end
  end
end
