# frozen_string_literal: true

module CourseManagement
  class AvailableCoursesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_available_course, only: %i[show edit update destroy]

    def index
      available_courses = AvailableCourse.includes([curriculum: :unit], :course, :academic_term)
                                         .order('units.name, curriculums.name')
                                         .dynamic_search(search_params(AvailableCourse))

      @pagy, @available_courses = pagy(available_courses)
    end

    def show
      @groups = @available_course.groups.includes(lecturers: [lecturer: %i[title user]])
    end

    def new
      @available_course = AvailableCourse.new
    end

    def create
      @available_course = AvailableCourse.new(available_course_params)
      group = @available_course.groups.build(name: 'Grup 1')

      if @available_course.save
        redirect_to edit_available_course_available_course_group_path(@available_course, group)
      else
        render(:new)
      end
    end

    def edit; end

    def update
      @available_course.update(available_course_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @available_course.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to available_courses_path, flash: { info: t(".#{message}") }
    end

    def set_available_course
      @available_course = AvailableCourse.find(params[:id])
    end

    def available_course_params
      params.require(:available_course).permit(
        :academic_term_id, :curriculum_id, :course_id
      )
    end
  end
end
