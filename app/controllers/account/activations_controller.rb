# frozen_string_literal: true

module Account
  class ActivationsController < ApplicationController
    include PhoneVerification
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

    def check_phone_verification
      response = check_verification_code

      return redirect_to_with_twilio_error(response, activation_path) unless response.ok?
      return redirect_to login_path, notice: t('.success') if update_process(session[:user_id],
                                                                             params[:phone_verification][:mobile_phone])

      redirect_to error_path, alert: t('errors.system_error')
    end

    private

    def update_process(user_id, mobile_phone)
      user = User.find(user_id)
      user.transaction do
        user.prospective_students.registered.update(archived: true)
        user.prospective_employees.update(archived: true)
        user.update!(mobile_phone: mobile_phone, activated: true, activated_at: Time.zone.now)
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
