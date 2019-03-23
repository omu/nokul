# frozen_string_literal: true

module Yoksis
  class StudentEducationLevelsController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:student_education_level).permit(:name, :code)
    end
  end
end
