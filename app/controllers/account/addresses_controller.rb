# frozen_string_literal: true

module Account
  class AddressesController < ApplicationController
    include LastUpdateFromMernis

    before_action :set_address, only: %i[edit update destroy]
    before_action :set_elapsed_time, only: %i[save_from_mernis]

    def index
      @addresses = current_user.addresses.includes(district: [:city])
    end

    def new
      @address = current_user.addresses.informal.new
    end

    def edit; end

    def create
      @address = current_user.addresses.informal.new(address_params)
      @address.save ? redirect_with('success') : render(:new)
    end

    def update
      @address.update(address_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @address.destroy ? redirect_with('success') : redirect_with('warning')
    end

    def save_from_mernis
      Kps::AddressSaveJob.perform_later(current_user)
      redirect_with('will_update')
    end

    private

    def set_address
      @address = current_user.addresses.informal.find(params[:id])
    end

    def set_elapsed_time
      formal_address = current_user.addresses.formal
      return if formal_address.blank?
      elapsed_time(formal_address.first)
    end

    def redirect_with(message)
      redirect_to(addresses_path, notice: t(".#{message}"))
    end

    def address_params
      params.require(:address).permit(:phone_number, :full_address, :district_id)
    end
  end
end
