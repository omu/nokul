# frozen_string_literal: true

module Admin
  class UnitStatusesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:unit_status).permit(:name, :code)
    end
  end
end
