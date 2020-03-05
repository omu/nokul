# frozen_string_literal: true

module Reference
  class ScholarshipTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:scholarship_type).permit(:name, :active)
    end
  end
end
