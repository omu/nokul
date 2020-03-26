# frozen_string_literal: true

module Reference
  class AccreditationInstitutionsController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:accreditation_institution).permit(:name)
    end
  end
end
