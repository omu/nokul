# frozen_string_literal: true

module Reference
  class CourseTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:course_type).permit(:name, :code, :min_credit)
    end
  end
end
