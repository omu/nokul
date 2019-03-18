# frozen_string_literal: true

module Reference
  class AssessmentMethodsController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:assessment_method).permit(:name)
    end
  end
end
