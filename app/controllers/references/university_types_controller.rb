# frozen_string_literal: true

module References
  class UniversityTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:university_type).permit(:name, :code)
    end
  end
end
