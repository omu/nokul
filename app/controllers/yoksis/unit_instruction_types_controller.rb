# frozen_string_literal: true

module Yoksis
  class UnitInstructionTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:unit_instruction_type).permit(:name, :code)
    end
  end
end
