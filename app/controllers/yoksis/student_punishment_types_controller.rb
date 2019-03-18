# frozen_string_literal: true

module Yoksis
  class StudentPunishmentTypesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_punishment_type).permit(:name, :code)
    end
  end
end
