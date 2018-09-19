# frozen_string_literal: true

class UnitsController < ApplicationController
  before_action :set_unit, only: %i[edit update destroy show courses]

  def index
    units = Unit.includes(
      :unit_status, :unit_instruction_language, :unit_instruction_type, :unit_type, district: [:city]
    )

    @pagy, @units = pagy(smart_search(units))
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
    @unit.destroy ? redirect_to(units_path, notice: t('.success')) : redirect_with('warning')
  end

  def courses
    render json: @unit.courses.to_json(methods: :name)
  end

  private

  def smart_search(units)
    params[:term].present? ? units.search(params[:term]) : dynamic_search(units)
  end

  def dynamic_search(units)
    %i[duration unit_status_id unit_instruction_type_id unit_instruction_language_id].each do |param|
      units = units.send(param, params[param]) if params[param].present?
    end
    units
  end

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
