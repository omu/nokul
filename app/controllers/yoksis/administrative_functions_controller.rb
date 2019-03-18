# frozen_string_literal: true

module Yoksis
  class AdministrativeFunctionsController < ApplicationController
    include YoksisResource

    private

    def secure_params
      params.require(:administrative_function).permit(:name, :code)
    end
  end
end
