# frozen_string_literal: true

module Account
  class ActivationsController < ApplicationController
    before_action :redirect_to_root, if: -> { user_signed_in? }
    skip_before_action :authenticate_user!
    layout 'guest'

    def new
      @activation = Activation::ActivationService.new
    end

    def create
      @activation = Activation::ActivationService.new(params[:activation])
      @activation.active
      session[:user_id] = @activation.user&.id

      respond_to :js
    end

    # rubocop:disable Metrics/AbcSize
    def check_phone_verification
      verify = params[:phone_verification]
      response = Twilio::Verify.check_verification_code(verify[:mobile_phone], verify[:verification_code])

      if response == 'ok'
        return redirect_to login_path, notice: t('.success') if update_process(session[:user_id],
                                                                               verify[:mobile_phone])

        redirect_to activation_path, alert: t('account.activations.system_error')
      else
        redirect_to activation_path,
                    alert: t("twilio.errors.#{response.error_code}", default: t('account.activations.system_error'))
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def update_process(user_id, phone)
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

    def redirect_to_root
      redirect_to(:root)
    end
  end
end
