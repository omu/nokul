# frozen_string_literal: true

module CourseManagement
  class AvailableCourseGroupsController < ApplicationController
    before_action :set_available_course
    before_action :set_available_course_group, only: %i[edit update destroy]

    def new
      @available_course_group = @available_course.groups.new
    end

    def create
      @available_course_group = @available_course.groups.new(available_course_group_params)
      @available_course_group.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @available_course_group.update(available_course_group_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @available_course_group.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to @available_course, flash: { info: t(".#{message}") }
    end

    def set_available_course
      @available_course = AvailableCourse.find(params[:available_course_id])
    end

    def set_available_course_group
      @available_course_group = @available_course.groups.find(params[:id])
    end

    def available_course_group_params
      params.require(:available_course_group).permit(
        :quota, :name, lecturers_attributes: %i[lecturer_id coordinator _destroy]
      )
    end
  end
end
