# frozen_string_literal: true

class UnitsController < ApplicationController
  include Pagy::Backend

  before_action :set_unit, only: %i[edit update destroy show]

  def index
    # TODO: refactor

    breadcrumb 'Birimler', units_path

    @units = Unit.includes(:unit_status, :unit_instruction_language, :unit_instruction_type, district: [:city])

    search_params = []
    %i[duration unit_status_id unit_instruction_type_id unit_instruction_language_id].each do |param|
      search_params << [param.to_s, params[param]] if params[param].present?
    end

    if params[:term]
      @units = @units.search(params[:term])
    elsif search_params.any?
      search_params.each do |column, value|
        @units = @units.where("#{column}": value.to_s)
      end
    else
      @units = @units.all
    end

    @pagy, @units = pagy(@units)
  end

  def show
    breadcrumb @unit.name, unit_path(@unit), match: :exact
    # breadcrumb 'Yeni Akademik Dönem', :new_academic_term_path
  end

  def new
    breadcrumb 'Birimler', units_path, match: :exact
    breadcrumb 'Yeni Birim', new_unit_path
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.save ? redirect_to(@unit, notice: t('.success')) : render(:new)
  end

  def edit
    breadcrumb 'Birimler', units_path, match: :exact
    breadcrumb @unit.name, edit_unit_path(@unit)
  end

  def update
    @unit.update(unit_params) ? redirect_to(@unit, notice: t('.success')) : render(:edit)
  end

  def destroy
    @unit.destroy ? redirect_to(units_path, notice: t('success')) : redirect_with('warning')
  end

  private

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
