# frozen_string_literal: true

module Reference
  class UnitStatusesController < ApplicationController
    include Pagy::Backend

    before_action :set_unit_status, only: %i[show edit update destroy]

    def index
      @pagy, @unit_statuses = pagy(UnitStatus.all)
    end

    def show
    end

    def new
      @unit_status = UnitStatus.new
    end

    def edit
    end

    def create
      @unit_status = UnitStatus.new(unit_status_params)
      @unit_status.save ? redirect_with('success') : render(:new)
    end

    def update
      if @unit_status.update(unit_status_params)
        redirect_to(@unit_status, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @unit_status.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(unit_statuses_path, notice: t(".#{message}"))
    end

    def set_unit_status
      @unit_status = UnitStatus.find(params[:id])
    end

    def unit_status_params
      params.require(:unit_status).permit(:name, :code)
    end
  end
end
