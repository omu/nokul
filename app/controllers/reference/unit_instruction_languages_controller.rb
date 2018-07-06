# frozen_string_literal: true

module Reference
  class UnitInstructionLanguagesController < ApplicationController
    include Pagy::Backend

    before_action :set_unit_instruction_language, only: %i[show edit update destroy]

    def index
      @pagy, @unit_instruction_languages = pagy(UnitInstructionLanguage.all)
    end

    def show
    end

    def new
      @unit_instruction_language = UnitInstructionLanguage.new
    end

    def edit
    end

    def create
      @unit_instruction_language = UnitInstructionLanguage.new(unit_instruction_language_params)
      @unit_instruction_language.save ? redirect_with('success') : render(:new)
    end

    def update
      if @unit_instruction_language.update(unit_instruction_language_params)
        redirect_to(@unit_instruction_language, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      @unit_instruction_language.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(unit_instruction_languages_path, notice: t(".#{message}"))
    end

    def set_unit_instruction_language
      @unit_instruction_language = UnitInstructionLanguage.find(params[:id])
    end

    def unit_instruction_language_params
      params.require(:unit_instruction_language).permit(:name, :code)
    end
  end
end
