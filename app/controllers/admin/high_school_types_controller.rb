# frozen_string_literal: true

module Admin
  class HighSchoolTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:high_school_type).permit(:name, :code)
    end
  end
end
