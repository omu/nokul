# frozen_string_literal: true

module Reference
  class CourseGroupTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:course_group_type).permit(:name)
    end
  end
end
