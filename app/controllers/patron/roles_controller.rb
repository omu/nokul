# frozen_string_literal: true

module Patron
  class RolesController < ApplicationController
    include Patron::SearchableModule

    before_action :set_role, only: %i[show edit update destroy]
    before_action :authorized?

    def index
      @roles = pagy_by_search(Patron::Role.order(:name))
    end

    def show
      @permissions = pagy_by_search(
        @role.permissions.order(:name), page_param: 'page_permission', pagy_name: :pagy_permissions
      )
      @users = pagy_by_search(
        @role.users, page_param: 'page_user', pagy_name: :pagy_users
      )
    end

    def new
      @role = Patron::Role.new
    end

    def edit; end

    def create
      @role = Patron::Role.new(role_params)
      @role.save ? redirect_to(@role, notice: t('.success')) : render(:new)
    end

    def update
      @role.update(role_params) ? redirect_to(@role, notice: t('.success')) : render(:new)
    end

    def destroy
      if @role.destroy
        redirect_to(patron_roles_path, notice: t('.success'))
      else
        redirect_to(patron_roles_path, alert: t('.warning'))
      end
    end

    private

    def authorized?
      authorize(@role || Patron::Role)
    end

    def set_role
      @role = Patron::Role.find(params[:id])
    end

    def role_params
      params.require(:patron_role).permit(:name, :identifier, :locked, permission_ids: [])
    end
  end
end
