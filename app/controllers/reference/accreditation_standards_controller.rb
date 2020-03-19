# frozen_string_literal: true

module Reference
  class AccreditationStandardsController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:accreditation_standard).permit(:name, :version)
    end
  end
end
