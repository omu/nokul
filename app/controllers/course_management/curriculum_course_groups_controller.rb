# frozen_string_literal: true

module CourseManagement
  class CurriculumCourseGroupsController < ApplicationController
    before_action :set_semester, only: %i[new create edit update destroy]
    before_action :set_curriculum_course_group, only: %i[edit update destroy]

    def new
      @curriculum_course_group = @semester.curriculum_course_groups.new
    end

    def edit
      @curriculum_course_group.build_curriculum_courses
    end

    def create
      @curriculum_course_group = @semester.curriculum_course_groups.new(curriculum_course_params)
      @curriculum_course_group.save ? redirect_with('success') : render(:new)
    end

    def update
      @curriculum_course_group.update(curriculum_course_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @curriculum_course_group.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to curriculum_path(@semester.curriculum), flash: { notice: t(".#{message}") }
    end

    def set_curriculum_course_group
      @curriculum_course_group = @semester.curriculum_course_groups.find(params[:id])
    end

    def set_semester
      @semester = CurriculumSemesterDecorator.new(
        CurriculumSemester.find(params[:curriculum_semester_id])
      )
    end

    def curriculum_course_params
      params.require(:curriculum_course_group).permit(
        :course_group_id, :ects,
        curriculum_courses_attributes: %i[id course_id ects curriculum_semester_id]
      )
    end
  end
end
