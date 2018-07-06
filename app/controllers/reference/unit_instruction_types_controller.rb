# frozen_string_literal: true

module Reference
  class UnitInstructionTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_unit_instruction_type, only: %i[show edit update destroy]

    def index
      @pagy, @unit_instruction_types = pagy(UnitInstructionType.all)
    end

    def show
    end

    def new
      @unit_instruction_type = UnitInstructionType.new
    end

    def edit
    end

    def create
      @unit_instruction_type = UnitInstructionType.new(unit_instruction_type_params)
      @unit_instruction_type.save ? redirect_with('success') : render(:new)
    end

    def update
      if @unit_instruction_type.update(unit_instruction_type_params)
        redirect_to(@unit_instruction_type, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @unit_instruction_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(unit_instruction_types_path, notice: t(".#{message}"))
    end

    def set_unit_instruction_type
      @unit_instruction_type = UnitInstructionType.find(params[:id])
    end

    def unit_instruction_type_params
      params.require(:unit_instruction_type).permit(:name, :code)
    end
  end
end
