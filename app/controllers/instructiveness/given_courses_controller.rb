# frozen_string_literal: true

module Instructiveness
  class GivenCoursesController < ApplicationController
    include SearchableModule

    before_action :set_employee
    before_action :set_course, except: :index

    def index
      courses = @employee.given_courses.includes(:unit, curriculum_course: :course)
                         .order('units.name', 'courses.name')
                         .dynamic_search(search_params(AvailableCourse))

      @pagy, @courses = pagy(courses)
    end

    def show
      @groups = @course.groups.includes(:lecturers)
    end

    def students
      @groups = @course.groups
    end

    private

    def set_employee
      @employee = current_user.employees.active.last
      redirect_to(root_path, alert: t('.errors.no_employee_record')) unless @employee
    end

    def set_course
      @course = @employee.given_courses.find(params[:id])
    end
  end
end
