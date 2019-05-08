# frozen_string_literal: true

module Patron
  class AssignmentsController < ApplicationController
    include Patron::SearchableModule

    before_action :set_user, only: %i[edit show update preview_scope]
    before_action :authorized?

    def index
      @users = pagy_by_search(User.all)
    end

    def show
      @collections = {
        roles: pagy_multi_by_search(@user.roles, page_param: 'page_role'),
        permissions: pagy_multi_by_search(@user.permissions, page_param: 'page_permission'),
        query_stores: pagy_multi_by_search(@user.query_stores, page_param: 'page_query_store')
      }
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to([:patron, :assignment, id: @user], notice: t('.success'))
      else
        render(:edit)
      end
    end

    def preview_scope
      query_stores = @user.query_stores.where(scope_name: params[:scope])

      if query_stores.present?
        @scope      = query_stores.first.scope_klass
        @records    = @scope.preview_for_records(query_stores)
        @collection = pagy_by_search(@records)
      else
        redirect_to([:patron, :assignment, id: @user], alert: t('.error'))
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:id])
    end

    def authorized?
      authorize %i[patron assignment]
    end

    def user_params
      params.require(:user).permit(role_ids: [], query_store_ids: [])
    end
  end
end
