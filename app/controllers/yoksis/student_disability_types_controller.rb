# frozen_string_literal: true

module Yoksis
  class StudentDisabilityTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_disability_type).permit(:name, :code)
    end
  end
end
