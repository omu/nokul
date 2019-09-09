# frozen_string_literal: true

module Account
  class SettingsController < ApplicationController
    include PhoneVerification

    def index; end

    def phone_setting; end

    # rubocop:disable Metrics/AbcSize
    def phone_verification
      phone = current_user[:mobile_phone] = TelephoneNumber.parse(params.dig(:user, :mobile_phone)).e164_number

      return respond_to :js unless current_user.valid? && current_user.mobile_phone_changed?

      flash[:alert] = t('errors.system_error') unless Twilio::Verify.send_phone_verification_code(phone).ok?

      respond_to :js
    end

    def update_mobile_phone
      phone = params[:phone_verification][:mobile_phone]
      response = check_verification_code

      return redirect_to_with_twilio_error(response, settings_path) unless response.ok?
      return redirect_to settings_path, notice: t('.success') if current_user.update(mobile_phone: phone)

      redirect_to settings_path, alert: t('errors.system_error')
    end
    # rubocop:enable Metrics/AbcSize
  end
end
