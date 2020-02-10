# frozen_string_literal: true

module Instructiveness
  class GivenCoursesController < ApplicationController
    before_action :set_employee
    before_action :set_course, except: :index

    def index
      @courses = @employee.available_courses.includes(:unit, curriculum_course: :course)
                          .order('units.name', 'courses.name')
    end

    def show
      @groups = @course.groups.includes(:lecturers)
    end

    def students
      @groups = @course.groups.includes(course_enrollments: [semester_registration: [student: :user]])
    end

    private

    def set_employee
      @employee = current_user.employees.active.last
    end

    def set_course
      @course = @employee.available_courses.find(params[:id])
    end
  end
end
