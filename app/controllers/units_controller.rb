# frozen_string_literal: true

class UnitsController < ApplicationController
  before_action :set_unit, only: %i[edit update destroy show]

  def index
    @units = if params[:term]
               Unit.autocomplete(params[:term])
             else
               Unit.all
             end
  end

  def show; end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.save ? redirect_with('success') : render(:new)
  end

  def edit; end

  def update
    @unit.update(unit_params) ? redirect_with('success') : render(:edit)
  end

  def destroy
    @unit.destroy ? redirect_with('success') : redirect_with('warning')
  end

  private

  def redirect_with(message)
    redirect_to(units_path, notice: t(".#{message}"))
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
