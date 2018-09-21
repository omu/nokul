# frozen_string_literal: true

module CourseManagement
  class CourseGroupTypesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_course_group_type, only: %i[edit update destroy]

    def index
      @course_group_types = pagy_by_search(CourseGroupType.all)
    end

    def new
      @course_group_type = CourseGroupType.new
    end

    def create
      @course_group_type = CourseGroupType.new(course_group_type_params)
      @course_group_type.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @course_group_type.update(course_group_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @course_group_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(course_group_types_path, notice: t(".#{message}"))
    end

    def set_course_group_type
      @course_group_type = CourseGroupType.find(params[:id])
    end

    def course_group_type_params
      params.require(:course_group_type).permit(:name)
    end
  end
end
