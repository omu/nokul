# frozen_string_literal: true

module Admin
  class LanguagesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:language).permit(:name, :iso)
    end
  end
end
