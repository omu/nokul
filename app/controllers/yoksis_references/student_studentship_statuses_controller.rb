# frozen_string_literal: true

module YoksisReferences
  class StudentStudentshipStatusesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_studentship_status).permit(:name, :code)
    end
  end
end
