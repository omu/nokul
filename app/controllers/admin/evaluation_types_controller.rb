# frozen_string_literal: true

module Admin
  class EvaluationTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:evaluation_type).permit(:name)
    end
  end
end
