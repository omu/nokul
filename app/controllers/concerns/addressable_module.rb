# frozen_string_literal: true

module AddressableModule
  extend ActiveSupport::Concern
  include UpdateableFromMernis

  # rubocop:disable Metrics/BlockLength
  # rubocop:disable Rails/LexicallyScopedActionFilter
  included do
    before_action :set_controller_variables
    before_action :set_address, only: %i[edit update destroy]
    before_action :set_elapsed_time, only: %i[save_from_mernis]
    before_action :check_existing_addresses, only: %i[new create]

    def index
      @addresses = @user.addresses.order(:type).includes(district: :city)
    end

    def new
      @address = @user.addresses.informal.new
    end

    def edit; end

    def create
      @address = @user.addresses.informal.new(address_params)
      @address.save ? redirect_with('success') : render(:new)
    end

    def update
      @address.update(address_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      if @address.destroy
        redirect_with('success')
      else
        redirect_to(@index_path, alert: t('.warning'))
      end
    end

    def save_from_mernis
      Kps::AddressSaveJob.perform_later(@user)
      redirect_with('will_update')
    end

    private

    def set_controller_variables
      module_name = controller_path.split('/').first

      if module_name == 'user_management'
        @user = User.friendly.find(params[:user_id])
        @index_path = [:user_management, @user, :addresses]
      elsif module_name == 'account'
        @user = current_user
        @index_path = [:addresses]
      end
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
      redirect_to @index_path, notice: t('.already_have_informal_address') if @user.addresses.informal.present?
    end

    def redirect_with(message)
      redirect_to(@index_path, notice: t(".#{message}"))
    end

    def address_params
      params.require(:address).permit(:phone_number, :full_address, :district_id, :country)
    end
  end
  # rubocop:enable Metrics/BlockLength
  # rubocop:enable Rails/LexicallyScopedActionFilter
end
