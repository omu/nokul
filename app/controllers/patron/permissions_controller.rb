# frozen_string_literal: true

module Patron
  class PermissionsController < ApplicationController
    include SearchableModule

    def index
      @permissions = pagy_by_search(Patron::Permission.order(:name))

      authorize @permissions
    end

    def show
      @permission = Patron::Permission.find(params[:id])
      @roles      = pagy_by_search(@permission.roles)

      authorize @permission
    end
  end
end
