# frozen_string_literal: true

module Admin
  class UnitTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:unit_type).permit(:name, :code, :group)
    end
  end
end
