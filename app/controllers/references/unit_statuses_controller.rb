# frozen_string_literal: true

module References
  class UnitStatusesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:unit_status).permit(:name, :code)
    end
  end
end
