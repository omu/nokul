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

      @roles = pagy_by_search(
        @permission.roles.order(:name), page_param: 'page_role', pagy_name: :pagy_roles
      )
      @users = pagy_by_search(
        @permission.users, page_param: 'page_user', pagy_name: :pagy_users
      )

      authorize @permission
    end
  end
end
