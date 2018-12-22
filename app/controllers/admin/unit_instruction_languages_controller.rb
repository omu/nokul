# frozen_string_literal: true

module Admin
  class UnitInstructionLanguagesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:unit_instruction_language).permit(:name, :code)
    end
  end
end
