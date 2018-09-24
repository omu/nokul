# frozen_string_literal: true

module YoksisReferences
  class UnitInstructionTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:unit_instruction_type).permit(:name, :code)
    end
  end
end
