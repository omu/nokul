# frozen_string_literal: true

module References
  class UnitTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:unit_type).permit(:name, :code)
    end
  end
end
