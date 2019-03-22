# frozen_string_literal: true

module Yoksis
  class UniversityTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:university_type).permit(:name, :code)
    end
  end
end
