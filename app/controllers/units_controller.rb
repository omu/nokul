# frozen_string_literal: true

class UnitsController < ApplicationController
  include Pagy::Backend
  before_action :set_unit, only: %i[edit update destroy show]

  def index
    breadcrumb t('.common.units'), units_path

    units = Unit.includes(:unit_status, :unit_instruction_language, :unit_instruction_type, district: [:city])

    @pagy, @units = if params[:term].present?
                      pagy(smart_search(units))
                    else
                      pagy(dynamic_search(units))
                    end
  end

  def show
    breadcrumb t('.common.units'), units_path, match: :exact
    breadcrumb @unit.name, unit_path(@unit)
  end

  def new
    breadcrumb t('.common.units'), units_path, match: :exact
    breadcrumb t('.form_title'), new_unit_path
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.save ? redirect_to(@unit, notice: t('.success')) : render(:new)
  end

  def edit
    breadcrumb t('.common.units'), units_path, match: :exact
    breadcrumb @unit.name, unit_path(@unit), match: :exact
    breadcrumb t('action_group.edit'), edit_unit_path(@unit)
  end

  def update
    @unit.update(unit_params) ? redirect_to(@unit, notice: t('.success')) : render(:edit)
  end

  def destroy
    @unit.destroy ? redirect_to(units_path, notice: t('.success')) : redirect_with('warning')
  end

  private

  def smart_search(units)
    units.search(params[:term])
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
      :name, :yoksis_id, :foet_code, :founded_at, :duration, :type, :district_id, :ancestry, :unit_status_id,
      :unit_instruction_language_id, :unit_instruction_type_id, :university_type_id
    )
  end
end
