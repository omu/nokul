# frozen_string_literal: true

module Yoksis
  class StudentDropOutTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_drop_out_type).permit(:name, :code)
    end
  end
end
