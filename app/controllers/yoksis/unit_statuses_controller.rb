# frozen_string_literal: true

module Yoksis
  class UnitStatusesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:unit_status).permit(:name, :code)
    end
  end
end
