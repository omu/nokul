# frozen_string_literal: true

module References
  class UnitInstructionTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_unit_instruction_type, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @unit_instruction_types = pagy(UnitInstructionType.all)
    end

    def show
      breadcrumb @unit_instruction_type.name, unit_instruction_type_path
    end

    def new
      breadcrumb t('.form_title'), new_unit_instruction_type_path
      @unit_instruction_type = UnitInstructionType.new
    end

    def edit
      breadcrumb t('.form_title'), edit_unit_instruction_type_path
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

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), unit_instruction_types_path, match: :exact
    end

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
