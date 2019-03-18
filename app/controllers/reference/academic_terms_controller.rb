# frozen_string_literal: true

module Reference
  class AcademicTermsController < ApplicationController
    include ReferenceResource

    def index
      @academic_terms = pagy_by_search(AcademicTerm.order(:year, :term))
    end

    private

    def secure_params
      params.require(:academic_term).permit(:year, :term, :start_of_term, :end_of_term, :active)
    end
  end
end
