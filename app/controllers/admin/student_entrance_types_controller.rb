# frozen_string_literal: true

module Admin
  class StudentEntranceTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_entrance_type).permit(:name, :code)
    end
  end
end
