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
      @available_course_group.save ? redirect_to(@available_course, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      if @available_course_group.update(available_course_group_params)
        redirect_to(@available_course, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      if @available_course_group.destroy
        redirect_to(@available_course, notice: t('.success'))
      else
        redirect_to(available_courses_path(@available_course), alert: t('.warning'))
      end
    end

    private

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
