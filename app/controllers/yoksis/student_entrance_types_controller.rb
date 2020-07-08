# frozen_string_literal: true

module Yoksis
  class StudentEntranceTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_entrance_type).permit(:name, :code, :abroad)
    end
  end
end
