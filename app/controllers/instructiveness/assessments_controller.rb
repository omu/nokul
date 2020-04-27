# frozen_string_literal: true

module Instructiveness
  class AssessmentsController < ApplicationController
    before_action :set_employee
    before_action :set_course
    before_action :set_assessment
    before_action :check_date_range, except: :show
    before_action :set_enrollments
    before_action :authorized?
    before_action :not_saved?, only: %i[edit update]
    before_action :coordinator?, only: %i[save draft]

    def show; end

    def edit
      @grades = @assessment.grades_under_authority_of(@employee) +
                @assessment.build_grades_for(@enrollments.where.not(id: @assessment.grades.map(&:course_enrollment_id)))
    end

    def update
      return redirect_with('success') if @assessment.update(assessment_params)

      @grades = @assessment.grades.select { |grade| @enrollments.ids.include?(grade.course_enrollment_id) }
      render(:edit)
    end

    def save
      return redirect_with('not_draft_error') unless @assessment.draft?
      return redirect_with('not_fully_graded_error') unless @assessment.fully_graded?

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

    def set_course
      @course = @employee.given_courses.find(params[:given_course_id])
    end

    def set_assessment
      assessment = @course.course_assessment_methods.find(params[:id])
      @assessment = AssessmentDecorator.new(assessment)
    end

    def check_date_range
      redirect_with('.errors.not_proper_event_range') unless @assessment.results_announcement_active?
    end

    def set_enrollments
      @enrollments = @course.enrollments_under_authority_of(@employee)
      redirect_to given_course_path(@course), flash: { info: t('.errors.no_enrollments') } if @enrollments.empty?
    end

    def authorized?
      authorize(@employee, policy_class: Instructiveness::AssessmentPolicy)
    end

    def not_saved?
      redirect_with('.errors.saved') if @assessment.saved?
    end

    def coordinator?
      redirect_with('.errors.not_coordinator') unless @employee.coordinatorships.include?(@course)
    end

    def assessment_params
      params.require(:course_assessment_method)
            .permit(grades_attributes: %i[id course_enrollment_id lecturer_id point])
            .merge(status: :draft)
    end
  end
end
