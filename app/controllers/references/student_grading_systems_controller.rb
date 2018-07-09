# frozen_string_literal: true

module References
  class StudentGradingSystemsController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_grading_system).permit(:name, :code)
    end
  end
end
