# frozen_string_literal: true

module Reference
  class UnitTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_unit_type, only: %i[show edit update destroy]

    def index
      @pagy, @unit_types = pagy(UnitType.all)
    end

    def show; end

    def new
      @unit_type = UnitType.new
    end

    def edit; end

    def create
      @unit_type = UnitType.new(unit_type_params)
      @unit_type.save ? redirect_with('success') : render(:new)
    end

    def update
      if @unit_type.update(unit_type_params)
        redirect_to(@unit_type, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @unit_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(unit_types_path, notice: t(".#{message}"))
    end

    def set_unit_type
      @unit_type = UnitType.find(params[:id])
    end

    def unit_type_params
      params.require(:unit_type).permit(:name, :code)
    end
  end
end
