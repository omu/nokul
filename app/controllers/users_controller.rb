# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend

  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_identities, only: :show
  before_action :set_addresses, only: :show

  def index
    @pagy, @users = if params[:term].present?
                      pagy(User.all.search(params[:term]))
                    else
                      pagy(User.all)
                    end
  end

  def show
    @employees = @user.employees.includes(:title).order(active: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save ? redirect_with('.success') : render(:new)
  end

  def edit; end

  def update
    @user.update_without_password(user_params) ? redirect_with('.success') : render(:edit)
  end

  def destroy
    @user.destroy ? redirect_with('.success') : redirect_with('.warning')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_identities
    @identities = @user.identities
  end

  def set_addresses
    @addresses = @user.addresses
  end

  def user_params
    params.require(:user).permit(:id_number, :email, :password, :password_confirmation, :preferred_language)
  end

  def redirect_with(message)
    redirect_to(users_path, notice: t(".#{message}"))
  end
end
