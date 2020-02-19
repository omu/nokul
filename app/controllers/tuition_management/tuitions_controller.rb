# frozen_string_literal: true

module TuitionManagement
  class TuitionsController < ApplicationController
    before_action :set_tuition, only: %i[edit update]

    def index
      @tuitions = Tuition.all
    end

    def new
      @tuition = Tuition.new
    end

    def create
      @tuition = Tuition.new(tuition_params)
      @tuition.save ? redirect_to(:tuitions, notice: 'Başarılı') : render(:new)
    end

    def edit; end

    def update
      @tuition.update(tuition_params) ? redirect_to(:tuitions, notice: 'Başarılı') : render(:edit)
    end

    def units
      @units = Unit.faculties
      respond_to do |format|
        format.json
      end
    end

    private

    def set_tuition
      @tuition = Tuition.find(params[:id])
    end

    def tuition_params
      params.require(:tuition).permit(:academic_term_id, :fee, :foreign_student_fee, unit_ids: [])
    end
  end
end
