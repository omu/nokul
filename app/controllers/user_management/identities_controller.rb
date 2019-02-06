# frozen_string_literal: true

module UserManagement
  class IdentitiesController < ApplicationController
    include LastUpdateFromMernis

    before_action :set_user
    before_action :set_identity, only: %i[edit update destroy]
    before_action :set_elapsed_time, only: %i[save_from_mernis]

    def index
      @identities = @user.identities
    end

    def new
      @identity = @user.identities.informal.new
    end

    def create
      @identity = @user.identities.informal.new(address_params)
      @identity.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @identity.update(address_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      if @identity.destroy
        redirect_with('success')
      else
        redirect_to([:user_management, @user, :identities], alert: t('.warning'))
      end
    end

    def save_from_mernis
      Kps::AddressSaveJob.perform_later(@user)
      redirect_with('will_update')
    end

    private

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def set_identity
      @identity = @user.identities.find(params[:id])
    end

    def set_elapsed_time
      formal_address = @user.identities.formal
      return if formal_address.blank?

      elapsed_time(formal_address.first)
    end

    def redirect_with(message)
      redirect_to([:user_management, @user, :identities], notice: t(".#{message}"))
    end

    def identity_params
      params.require(:identity).permit(:phone_number, :full_address, :district_id, :country)
    end
  end
end
