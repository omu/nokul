# frozen_string_literal: true

module Account
  class ActivationsController < ApplicationController
    before_action :check_user_login
    skip_before_action :authenticate_user!
    layout 'guest'

    def new
      @activation = Activation::ActivationService.new
    end

    def create
      @activation = Activation::ActivationService.new(params[:activation])
      @activation.active
      respond_to do |format|
        format.js
      end
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def check_phone_verification
      verify = params[:phone_verification]
      response = Twilio::Verify.check_verification_code(verify[:mobile_phone], verify[:verification_code])

      if response == 'ok'
        if update_process(params[:students], params[:employees], params[:user], verify[:mobile_phone])
          redirect_to login_path, notice: t('.success')
        else
          redirect_to activation_path, alert: t('account.activations.system_error')
        end
      else
        redirect_to activation_path,
                    alert: t("twilio.errors.#{response.error_code}", default: t('account.activations.system_error'))
      end
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    def update_process(prospective_student_ids, prospective_employee_ids, user_id, phone)
      ActiveRecord::Base.transaction do
        user = User.find(user_id)
        ProspectiveStudent.archive(prospective_student_ids)
        ProspectiveEmployee.archive(prospective_employee_ids)
        user.update(activated: true, activated_at: Time.zone.now)
        user.addresses.formal.first.update(phone_number: phone)
      end
    end

    def check_user_login
      redirect_to root_path if user_signed_in?
    end
  end
end
