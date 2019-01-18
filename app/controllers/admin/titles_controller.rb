# frozen_string_literal: true

module Admin
  class TitlesController < ApplicationController
    include ReferenceResource

    private

    def secure_params
      params.require(:title).permit(:name, :code, :branch)
    end
  end
end
