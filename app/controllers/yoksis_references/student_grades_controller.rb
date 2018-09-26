# frozen_string_literal: true

module YoksisReferences
  class StudentGradesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:student_grade).permit(:name, :code)
    end
  end
end
