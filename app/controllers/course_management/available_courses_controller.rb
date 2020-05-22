# frozen_string_literal: true

module CourseManagement
  class AvailableCoursesController < ApplicationController
    include SearchableModule

    before_action :set_available_course, only: %i[show edit update destroy]
    before_action :authorized?

    def index
      available_courses = AvailableCourse.includes(:unit, :curriculum, :academic_term, curriculum_course: :course)
                                         .order('units.name, curriculums.name')
                                         .dynamic_search(search_params(AvailableCourse))

      @pagy, @available_courses = pagy(available_courses)
    end

    def show
      @groups = @available_course.groups.includes(lecturers: [lecturer: %i[title user]])
      @evaluation_types =
        @available_course.evaluation_types.includes(:evaluation_type, course_assessment_methods: :assessment_method)
    end

    def new
      @available_course = AvailableCourse.new
      @available_course.groups.build.lecturers.build
    end

    def create
      @available_course = AvailableCourse.new(available_course_params)
      return redirect_with('.errors.not_proper_event_range') unless @available_course.reifiable?

      @available_course.save ? redirect_to(@available_course, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      if @available_course.update(available_course_params)
        redirect_to(@available_course, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      return redirect_with('.errors.not_proper_event_range') unless @available_course.reifiable?

      message = @available_course.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to available_courses_path, flash: { info: t(".#{message}") }
    end

    def set_available_course
      available_course = AvailableCourse.find(params[:id])
      @available_course = AvailableCourseDecorator.new(available_course)
    end

    def authorized?
      authorize([:course_management, @available_course || AvailableCourse])
    end

    def available_course_params
      params.require(:available_course).permit(
        :curriculum_id, :curriculum_course_id, :unit_id, :coordinator_id,
        groups_attributes: [:id, :name, :quota, :_destroy,
                            lecturers_attributes: %i[id lecturer_id coordinator _destroy]]
      )
    end
  end
end
