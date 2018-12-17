# frozen_string_literal: true

module CourseManagement
  class CurriculumCoursesController < ApplicationController
    before_action :set_semester, only: %i[new create edit update destroy]
    before_action :set_curriculum_course, only: %i[edit update destroy]

    def new
      @curriculum_course = @semester.curriculum_courses.new
    end

    def edit; end

    def create
      @curriculum_course = @semester.curriculum_courses.new(curriculum_course_params)
      @curriculum_course.save ? redirect_with('success') : render(:new)
    end

    def update
      @curriculum_course.update(curriculum_course_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @curriculum_course.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to curriculum_path(@semester.curriculum), flash: { notice: t(".#{message}") }
    end

    def set_curriculum_course
      @curriculum_course = @semester.curriculum_courses.find(params[:id])
    end

    def set_semester
      @semester = CurriculumSemesterDecorator.new(
        CurriculumSemester.find(params[:curriculum_semester_id])
      )
    end

    def curriculum_course_params
      params.require(:curriculum_course).permit(:course_id, :ects, :type)
    end
  end
end
