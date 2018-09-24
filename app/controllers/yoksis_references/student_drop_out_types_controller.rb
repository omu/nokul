# frozen_string_literal: true

module YoksisReferences
  class StudentDropOutTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_drop_out_type).permit(:name, :code)
    end
  end
end
