# frozen_string_literal: true

module Yoksis
  class StudentGradesController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_grade).permit(:name, :code)
    end
  end
end
