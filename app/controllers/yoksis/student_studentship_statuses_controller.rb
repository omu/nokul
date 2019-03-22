# frozen_string_literal: true

module Yoksis
  class StudentStudentshipStatusesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_studentship_status).permit(:name, :code)
    end
  end
end
