# frozen_string_literal: true

module Admin
  class AdministrativeFunctionsController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:administrative_function).permit(:name, :code)
    end
  end
end
