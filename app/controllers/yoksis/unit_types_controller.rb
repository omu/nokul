# frozen_string_literal: true

module Yoksis
  class UnitTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:unit_type).permit(:name, :code, :group)
    end
  end
end
