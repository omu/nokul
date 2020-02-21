# frozen_string_literal: true

module Instructiveness
  class GivenCoursesController < ApplicationController
    include SearchableModule

    before_action :set_employee
    before_action :set_course, except: :index
    before_action :set_groups, except: :index
    before_action :authorized?

    def index
      courses = @employee.given_courses.includes(:unit, :academic_term, curriculum_course: :course)
                         .order('units.name', 'courses.name')
                         .dynamic_search(search_params(AvailableCourse))

      @pagy, @courses = pagy(courses)
    end

    def show
      @evaluation_types =
        @course.evaluation_types.includes(:evaluation_type, course_assessment_methods: :assessment_method)
    end

    def students; end

    private

    def set_employee
      not_found if (@employee = current_user.current_employee).nil?
    end

    def authorized?
      authorize(@employee, policy_class: Instructiveness::GivenCoursePolicy)
    end

    def set_groups
      @groups = @course.groups_under_authority_of(@employee).includes(:lecturers)
    end

    def set_course
      @course = @employee.given_courses.find(params[:id])
    end
  end
end
