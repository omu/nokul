# frozen_string_literal: true

module Yoksis
  class StudentEntrancePointTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_entrance_point_type).permit(:name, :code)
    end
  end
end
