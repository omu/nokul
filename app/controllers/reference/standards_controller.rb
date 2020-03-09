# frozen_string_literal: true

module Reference
  class StandardsController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:standard).permit(:name, :version)
    end
  end
end
