# frozen_string_literal: true

module UserManagement
  class UsersController < ApplicationController
    include PagyBackendWithHelpers
    include LastUpdateFromMernis

    before_action :set_user, only: %i[edit update destroy show]
    before_action :nullify_slug, only: :update

    def index
      @users = pagy_by_search(User.all)
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.save ? redirect_with('.success') : render(:new)
    end

    def edit; end

    def update
      if user_params[:password].blank? || user_params[:password_confirmation].blank?
        @user.update_without_password(user_params) ? redirect_with('.success') : render(:edit)
      else
        @user.update(user_params) ? redirect_with('.success') : render(:edit)
      end
    end

    def destroy
      if @user.destroy
        redirect_with('.success')
      else
        redirect_to(%i[user_management users], alert: t('.warning'))
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:id]) || User.find(params[:id])
    end

    def nullify_slug
      # generate a new slug when the e-mail changes
      @user.slug = nil unless user_params[:email] == @user.email
    end

    def user_params
      params.require(:user).permit(:id_number, :email, :password, :password_confirmation)
    end

    def redirect_with(message)
      redirect_to(%i[user_management users], notice: t(".#{message}"))
    end
  end
end
