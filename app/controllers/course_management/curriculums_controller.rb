# frozen_string_literal: true

module CourseManagement
  class CurriculumsController < ApplicationController
    include PagyBackendWithHelpers
    before_action :set_curriculum, only: %i[show edit update destroy]

    def index
      @pagy, @curriculums = pagy(
        Curriculum.includes(:unit).dynamic_search(search_params(Curriculum))
      )
    end

    def show; end

    def new
      @curriculum = Curriculum.new
    end

    def edit; end

    def create
      @curriculum = Curriculum.new(curriculum_params)
      @curriculum.save ? redirect_with('success') : render(:new)
    end

    def update
      @curriculum.update(curriculum_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      message = @curriculum.destroy ? 'success' : 'error'
      redirect_with(message)
    end

    private

    def redirect_with(message)
      redirect_to curriculums_path, flash: { notice: t(".#{message}") }
    end

    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    def curriculum_params
      params.require(:curriculum).permit(:name, :unit_id, :number_of_semesters, :status, program_ids: [])
    end
  end
end
