# frozen_string_literal: true

module Yoksis
  class UnitInstructionLanguagesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:unit_instruction_language).permit(:name, :code)
    end
  end
end
