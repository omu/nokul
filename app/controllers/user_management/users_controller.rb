# frozen_string_literal: true

module UserManagement
  class UsersController < ApplicationController
    include SearchableModule
    include UpdateableFromMernis

    before_action :set_user, except: :index
    before_action :nullify_slug, only: :update
    before_action :authorized?

    def index
      @users = pagy_by_search(User.all)
    end

    def show
      @identities = @user.identities
      @addresses = @user.addresses.includes(district: :city)
      @employees = @user.employees.includes(:title).order(active: :desc)
      @duties = @user.duties.includes(:unit)
      @students = @user.students.includes(:unit, :scholarship_type)
      @positions = @user.positions.includes(:administrative_function, :duty)
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
      @user.destroy ? redirect_with('.success') : redirect_with('.warning')
    end

    private

    def set_user
      @user = User.friendly.find(params[:id])
    end

    def authorized?
      authorize([:user_management, @user || User])
    end

    def nullify_slug
      # generate a new slug when the e-mail changes
      @user.slug = nil if user_params[:email].present?
    end

    def user_params
      params.require(:user).permit(:id_number, :email, :password, :password_confirmation, :preferred_language)
    end

    def redirect_with(message)
      redirect_to(users_path, notice: t(".#{message}"))
    end
  end
end
