# frozen_string_literal: true

module CourseManagement
  class CourseUnitGroupsController < ApplicationController
    before_action :set_course_unit_group, only: %i[edit update destroy]

    def index
      @course_unit_groups = pagy_by_search(CourseUnitGroup.includes(:unit, :course_group_type))
    end

    def new
      @course_unit_group = CourseUnitGroup.new
    end

    def create
      @course_unit_group = CourseUnitGroup.new(course_unit_group_params)
      @course_unit_group.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @course_unit_group.update(course_unit_group_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @course_unit_group.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(course_unit_groups_path, notice: t(".#{message}"))
    end

    def set_course_unit_group
      @course_unit_group = CourseUnitGroup.find(params[:id])
    end

    def course_unit_group_params
      params.require(:course_unit_group)
            .permit(:name, :total_ects_condition, :unit_id, :course_group_type_id, course_ids: [])
    end
  end
end
