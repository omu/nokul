# frozen_string_literal: true

module CourseManagement
  class CurriculumsController < ApplicationController
    include SearchableModule

    before_action :set_curriculum, only: %i[show edit update destroy openable_courses]

    def index
      curriculums = Curriculum.includes(:unit)
                              .order(status: :desc, name: :asc)
                              .order('units.name')
                              .dynamic_search(search_params(Curriculum))
      @pagy, @curriculums = pagy(curriculums)
    end

    def show
      @semesters = @curriculum.semesters
                              .includes(curriculum_course_groups: :course_group)
                              .order(:year, :sequence)
                              .group_by(&:year)
    end

    def new
      @curriculum = Curriculum.new
    end

    def edit; end

    def create
      @curriculum = Curriculum.new(curriculum_params)
      @curriculum.build_semesters(
        number_of_semesters: params.dig(:curriculum, :number_of_semesters),
        type: params.dig(:curriculum, :type)
      )
      @curriculum.save ? redirect_with('success') : render(:new)
    end

    def update
      @curriculum.update(curriculum_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @curriculum.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    def openable_courses
      @curriculum = CurriculumDecorator.new(@curriculum)
      render json: @curriculum.openable_courses_for_active_term
    end

    private

    def redirect_with(message)
      redirect_to curriculums_path, flash: { notice: t(".#{message}") }
    end

    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    def curriculum_params
      params.require(:curriculum).permit(
        :name, :unit_id, :status, program_ids: [],
                                  semesters_attributes: %i[id sequence year _destroy]
      )
    end
  end
end
