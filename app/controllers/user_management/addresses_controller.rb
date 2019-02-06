# frozen_string_literal: true

module UserManagement
  class AddressesController < ApplicationController
    include LastUpdateFromMernis

    before_action :set_user
    before_action :set_address, only: %i[edit update destroy]
    before_action :set_elapsed_time, only: %i[save_from_mernis]
    before_action :check_existing_addresses, only: %i[new create]

    def index
      @addresses = @user.addresses
    end

    def new
      @address = @user.addresses.informal.new
    end

    def create
      @address = @user.addresses.informal.new(address_params)
      @address.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @address.update(address_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      if @address.destroy
        redirect_with('success')
      else
        redirect_to([:user_management, @user, :addresses], alert: t('.warning'))
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

    def set_address
      @address = @user.addresses.informal.find(params[:id])
    end

    def set_elapsed_time
      formal_address = @user.addresses.formal
      return if formal_address.blank?

      elapsed_time(formal_address.first)
    end

    def check_existing_addresses
      if @user.addresses.informal.present?
        redirect_to [:user_management, @user, :addresses], notice: t('.already_have_informal_address')
      end
    end

    def redirect_with(message)
      redirect_to([:user_management, @user, :addresses], notice: t(".#{message}"))
    end

    def address_params
      params.require(:address).permit(:phone_number, :full_address, :district_id, :country)
    end
  end
end
