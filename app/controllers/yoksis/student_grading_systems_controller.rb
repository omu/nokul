# frozen_string_literal: true

module Yoksis
  class StudentGradingSystemsController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_grading_system).permit(:name, :code)
    end
  end
end
