# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend
  include LastUpdateFromMernis

  before_action :set_user, only: %i[show edit update destroy save_address_from_mernis save_identity_from_mernis]
  before_action :set_identities, only: :show
  before_action :set_addresses, only: :show
  before_action :set_address_elapsed_time, only: %i[save_address_from_mernis]
  before_action :set_identity_elapsed_time, only: %i[save_identity_from_mernis]

  def index
    @pagy, @users = if params[:term].present?
                      pagy(User.all.search(params[:term]))
                    else
                      pagy(User.all)
                    end
  end

  def show
    @employees = @user.employees.includes(:title).order(active: :desc)
    @duties = @user.duties.includes(:unit)
    @positions = @user.positions.includes(:administrative_function, :duty)
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
    @user.slug = nil if user_params[:email].present?
    @user.update_without_password(user_params) ? redirect_with('.success') : render(:edit)
  end

  def destroy
    @user.destroy ? redirect_with('.success') : redirect_with('.warning')
  end

  def save_address_from_mernis
    Kps::AddressSaveJob.perform_later(@user)
    redirect_to(@user, notice: t('.will_update'))
  end

  def save_identity_from_mernis
    Kps::IdentitySaveJob.perform_later(@user)
    redirect_to(@user, notice: t('.will_update'))
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def set_identities
    @identities = @user.identities
  end

  def set_addresses
    @addresses = @user.addresses
  end

  def set_address_elapsed_time
    formal_address = @user.addresses.formal
    return if formal_address.blank?

    elapsed_time(formal_address.first)
  end

  def set_identity_elapsed_time
    formal_identity = @user.identities.user_identity
    return if formal_identity.blank?

    elapsed_time(formal_identity)
  end

  def user_params
    params.require(:user).permit(:id_number, :email, :password, :password_confirmation, :preferred_language)
  end

  def redirect_with(message)
    redirect_to(users_path, notice: t(".#{message}"))
  end
end
