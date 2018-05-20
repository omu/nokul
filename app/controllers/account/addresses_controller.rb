# frozen_string_literal: true

module Account
  class AddressesController < ApplicationController
    before_action :set_address, only: %i[edit update destroy]
    before_action :check_formality, only: %i[edit update destroy]

    def index
      @addresses = current_user.addresses
    end

    def new
      @address = current_user.addresses.new
    end

    def edit; end

    def create
      @address = current_user.addresses.new(address_params)
      @address.save ? redirect_with('success') : render(:new)
    end

    def update
      @address.update(address_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      redirect_with('success') if @address.destroy
    end

    def update_from_mernis
      if (Time.zone.now - @address.updated_at) / 1.day < 7
        redirect_with('wait')
      else
        KpsAddressUpdateJob.perform_later(address)
        redirect_with('will_update')
      end
    end

    private

    def check_formality
      redirect_with('warning') if @address.formal?
    end

    def redirect_with(message)
      redirect_to(addresses_path, notice: t(".#{message}"))
    end

    def set_address
      @address = current_user.addresses.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:name, :phone_number, :full_address, :district_id)
    end
  end
end
