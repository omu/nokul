# frozen_string_literal: true

module UserManagement
  class UsersController < ApplicationController
    include SearchableModule
    include UpdateableFromMernis

    before_action :set_user, except: :index
    before_action :set_address_elapsed_time, only: %i[save_address_from_mernis]
    before_action :set_identity_elapsed_time, only: %i[save_identity_from_mernis]
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
      @students = @user.students.includes(:unit, :scholarship_type, :stage)
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

    def authorized?
      authorize([:user_management, @user || User])
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
