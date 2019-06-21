# frozen_string_literal: true

module PhoneVerification
  extend ActiveSupport::Concern

  def check(params, success_path, error_path)
    verify = params[:phone_verification]
    response = Twilio::Verify.check_verification_code(verify[:mobile_phone], verify[:verification_code])

    if response == 'ok'
      controller_case(verify, success_path, error_path)
    else
      redirect_to error_path,
                  alert: t("twilio.errors.#{response.error_code}", default: t('errors.system_error'))
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def controller_case(verify, success_path, error_path)
    case controller_name
    when 'registrations'
      return redirect_to success_path, notice: t('.success') if current_user.update(mobile_phone: verify[:mobile_phone])

      redirect_to error_path, alert: t('errors.system_error')
    when 'activations'
      return redirect_to success_path, notice: t('.success') if update_proscess_for_activation(session[:user_id],
                                                                                               verify[:mobile_phone])

      redirect_to error_path, alert: t('errors.system_error')
    end
    # rubocop:enable Metrics/AbcSize
  end

  def update_proscess_for_activation(user_id, phone)
    user = User.find(user_id)
    user.transaction do
      user.prospective_students.registered.update(archived: true)
      user.prospective_employees.update(archived: true)
      user.update!(mobile_phone: phone, activated: true, activated_at: Time.zone.now)
    end
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
    Rollbar.error(e, e.message)
    false
  end
end
