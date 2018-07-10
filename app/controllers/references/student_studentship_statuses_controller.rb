# frozen_string_literal: true

module References
  class StudentStudentshipStatusesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_studentship_status).permit(:name, :code)
    end
  end
end
