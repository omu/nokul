# frozen_string_literal: true

module Account
  class AddressesController < ApplicationController
    before_action :set_address, only: %i[edit update destroy]
    before_action :check_formality, only: %i[edit update destroy]
    before_action :set_formal_address, only: %i[save_from_mernis]
    before_action :set_elapsed_time, only: %i[save_from_mernis]

    def index
      @addresses = current_user.addresses.includes(district: [:city])
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
      @address.destroy ? redirect_with('success') : redirect_with('warning')
    end

    def save_from_mernis
      if @elapsed_time.present? && @elapsed_time < 7
        redirect_with('wait')
      else
        KpsAddressSaveJob.perform_later(current_user)
        redirect_with('will_update')
      end
    end

    private

    def set_formal_address
      @address = current_user.addresses.formal.presence ? current_user.addresses.formal : nil
    end

    def set_elapsed_time
      @elapsed_time = (Time.zone.now - current_user.addresses.formal.first.updated_at) / 1.day if @address.present?
    end

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
