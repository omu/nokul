# frozen_string_literal: true

module Patron
  class RolesController < ApplicationController
    include SearchableModule

    before_action :set_role, only: %i[show edit update destroy]

    def index
      @roles = pagy_by_search(Patron::Role.order(:name))
    end

    def show; end

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

    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:patron_role).permit(:name, :identifier, :locked, permission_ids: [])
    end
  end
end
