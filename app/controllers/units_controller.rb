# frozen_string_literal: true

class UnitsController < ApplicationController
  include PagyBackendWithHelpers
  before_action :set_unit, only: %i[edit update destroy show courses programs]

  def index
    units = Unit.includes(
      :unit_status, :unit_instruction_language, :unit_instruction_type, :unit_type, district: [:city]
    )

    @pagy, @units = pagy(units.dynamic_search(search_params(Unit)))
  end

  def show; end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.save ? redirect_to(@unit, notice: t('.success')) : render(:new)
  end

  def edit; end

  def update
    @unit.update(unit_params) ? redirect_to(@unit, notice: t('.success')) : render(:edit)
  end

  def destroy
    if @unit.destroy
      redirect_to(units_path, notice: t('.success'))
    else
      redirect_to(units_path, alert: t('.warning'))
    end
  end

  def courses
    @courses = @unit.courses.active
  end

  def programs
    @units = @unit.descendants.programs.active
    render json: @units
  end

  private

  def set_unit
    @unit = Unit.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(
      :name, :yoksis_id, :detsis_id, :foet_code, :founded_at, :duration, :district_id, :parent_id, :unit_status_id,
      :unit_instruction_language_id, :unit_instruction_type_id, :unit_type_id, :university_type_id
    )
  end
end
