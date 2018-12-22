# frozen_string_literal: true

module Admin
  class StudentEntrancePointTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_entrance_point_type).permit(:name, :code)
    end
  end
end
