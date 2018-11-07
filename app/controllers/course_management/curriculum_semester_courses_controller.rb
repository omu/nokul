# frozen_string_literal: true

module CourseManagement
  class CurriculumSemesterCoursesController < ApplicationController
    before_action :set_semester, only: %i[new create edit update destroy]
    before_action :set_semester_course, only: %i[edit update destroy]

    def new
      @semester_course = @semester.curriculum_semester_courses.new
    end

    def edit; end

    def create
      @semester_course = @semester.curriculum_semester_courses.new(semester_course_params)
      @semester_course.save ? redirect_with('success') : render(:new)
    end

    def update
      @semester_course.update(semester_course_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @semester_course.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to curriculum_path(@semester.curriculum), flash: { notice: t(".#{message}") }
    end

    def set_semester_course
      @semester_course = @semester.curriculum_semester_courses.find(params[:id])
    end

    def set_semester
      @semester = CurriculumSemester.find(params[:curriculum_semester_id])
    end

    def semester_course_params
      params.require(:curriculum_semester_course).permit(:course_id, :ects)
    end
  end
end
