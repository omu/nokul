# frozen_string_literal: true

module TuitionManagement
  class TuitionsController < ApplicationController
    include SearchableModule

    before_action :set_tuition, only: %i[edit update destroy]
    before_action :authorized?

    def index
      tuitions = Tuition.includes(:units, :unit_tuitions, :academic_term).where(
        params[:unit_id].present? ? { units: { id: params[:unit_id] } } : {}
      )

      @pagy, @tuitions = pagy(tuitions.dynamic_search(search_params(Tuition)))
    end

    def new
      @tuition = Tuition.new
    end

    def create
      @tuition = Tuition.new(tuition_params)
      @tuition.save ? redirect_to(:tuitions, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @tuition.update(tuition_params) ? redirect_to(:tuitions, notice: t('.success')) : render(:edit)
    end

    def destroy
      return redirect_to(:tuitions, notice: t('.success')) if @tuition.destroy

      redirect_to(:tuitions, alert: t('.warning'))
    end

    def units
      @units = params[:term].present? ? Unit.active.faculties.search(params[:term]) : Unit.active.faculties
      respond_to :json
    end

    private

    def set_tuition
      @tuition = Tuition.find(params[:id])
    end

    def authorized?
      authorize([:tuition_management, @tuition || Tuition])
    end

    def tuition_params
      params.require(:tuition).permit(:academic_term_id, :fee, :foreign_student_fee, unit_ids: [])
    end
  end
end
