# frozen_string_literal: true

module References
  class StudentEducationLevelsController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_education_level).permit(:name, :code)
    end
  end
end
