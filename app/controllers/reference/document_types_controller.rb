# frozen_string_literal: true

module Reference
  class DocumentTypesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:document_type).permit(:name, :active)
    end
  end
end
