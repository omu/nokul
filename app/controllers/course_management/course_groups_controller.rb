# frozen_string_literal: true

module CourseManagement
  class CourseGroupsController < ApplicationController
    include Pagy::Backend

    before_action :set_course_group, only: %i[show edit update destroy]
    before_action :authorized?

    def index
      course_groups = CourseGroup.includes(:unit, :course_group_type)
                                 .dynamic_search(search_params(CourseGroup))
      @pagy, @course_groups = pagy(course_groups)
    end

    def show
      @courses = @course_group.courses
    end

    def new
      @course_group = CourseGroup.new
    end

    def create
      @course_group = CourseGroup.new(course_group_params)
      @course_group.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @course_group.update(course_group_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @course_group.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(course_groups_path, notice: t(".#{message}"))
    end

    def set_course_group
      @course_group = CourseGroup.find(params[:id])
    end

    def authorized?
      authorize([:course_management, @course_group || CourseGroup])
    end

    def course_group_params
      params.require(:course_group)
            .permit(:name, :total_ects_condition, :unit_id, :course_group_type_id, course_ids: [])
    end
  end
end
