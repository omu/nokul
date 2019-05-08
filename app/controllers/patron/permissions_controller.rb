# frozen_string_literal: true

module Patron
  class PermissionsController < ApplicationController
    include Patron::SearchableModule

    def index
      @permissions = pagy_by_search(Patron::Permission.order(:name))

      authorize @permissions
    end

    def show
      @permission = Patron::Permission.find(params[:id])

      @collections = {
        roles: pagy_multi_by_search(@permission.roles.order(:name), page_param: 'page_permission'),
        users: pagy_multi_by_search(@permission.users, page_param: 'page_user')
      }

      authorize @permission
    end
  end
end
