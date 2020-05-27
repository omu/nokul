# frozen_string_literal: true

module CourseManagement
  class AvailableCourseGroupsController < ApplicationController
    before_action :set_available_course
    before_action :set_lecturers
    before_action :set_available_course_group, only: %i[edit update destroy]
    before_action :authorized?
    before_action :event_active?, except: %i[edit update]

    def new
      @available_course_group = @available_course.groups.new
      @available_course_group.lecturers.build
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
      available_course = AvailableCourse.find(params[:available_course_id])
      @available_course = AvailableCourseDecorator.new(available_course)
    end

    def set_available_course_group
      @available_course_group = @available_course.groups.find(params[:id])
    end

    def set_lecturers
      @lecturers = @available_course.unit.subtree_employees
    end

    def authorized?
      authorize([:course_management, @available_course_group || AvailableCourseGroup])
    end

    def event_active?
      return if @available_course.manageable?

      redirect_to(@available_course,
                  flash: { info: t('errors.not_proper_event_range', scope: %i[course_management available_courses]) })
    end

    def available_course_group_params
      params.require(:available_course_group).permit(
        :quota, :name, lecturers_attributes: %i[id lecturer_id coordinator _destroy]
      )
    end
  end
end
