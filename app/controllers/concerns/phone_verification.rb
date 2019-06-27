# frozen_string_literal: true

module PhoneVerification
  extend ActiveSupport::Concern

  private

  def check_verification_code
    Twilio::Verify.check_verification_code(
      phone_verification_params[:mobile_phone],
      phone_verification_params[:verification_code]
    )
  end

  def redirect_to_with_twilio_error(response, path)
    redirect_to path, alert: t("twilio.errors.#{response.error_code}", default: t('errors.system_error'))
  end

  def phone_verification_params
    params.require(:phone_verification).permit(:mobile_phone, :verification_code)
  end
end
