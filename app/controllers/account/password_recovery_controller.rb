# frozen_string_literal: true

module Account
  class PasswordRecoveryController < ApplicationController
    before_action :redirect_to_root, if: -> { user_signed_in? }
    skip_before_action :authenticate_user!
    layout 'guest'

    def new
      @password_recovery = PasswordRecoveryService.new
    end

    def create
      @password_recovery = PasswordRecoveryService.new(password_recovery_create_params)
      if verify_recaptcha && @password_recovery.valid? && @password_recovery.send_verification_code
        redirect_to(password_recovery_update_path(token: @password_recovery.signed_id),
                    notice: I18n.t('.verification.code_sent'))
      else
        render(:new)
      end
    end

    def edit
      @password_recovery = PasswordRecoveryService.new
      redirect_to password_recovery_path unless params[:token]
    end

    def update
      @password_recovery = PasswordRecoveryService.new(password_recovery_update_params)
      if @password_recovery.update_password
        redirect_to login_path, notice: I18n.t('.account.password_recovery.success')
      else
        render(:edit)
      end
    end

    private

    def password_recovery_create_params
      params.required(:password_recovery).permit(:id_number, :mobile_phone, :token)
    end

    def password_recovery_update_params
      params.required(:password_recovery).permit(:country, :password, :password_confirmation, :token,
                                                 :verification_code)
    end

    def redirect_to_root
      redirect_to(:root)
    end
  end
end
