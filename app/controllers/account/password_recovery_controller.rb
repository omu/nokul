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
      @password_recovery = PasswordRecoveryService.new(params[:password_recovery])
      if verify_recaptcha && @password_recovery.valid? && @password_recovery.send_verification_code
        signed_id = @password_recovery.signed_id
        redirect_to(password_recovery_new_password_path(token: signed_id),
                    notice: I18n.t('.account.password_recovery.verification_code_sent'))
      else
        render(:new)
      end
    end

    def edit
      @password_recovery = PasswordRecoveryService.new
      redirect_to password_recovery_path unless params[:token]
    end

    def update
      @password_recovery = PasswordRecoveryService.new(params[:password_recovery])
      if @password_recovery.update_password
        redirect_to login_path, notice: I18n.t('.account.password_recovery.success')
      else
        render(:edit)
      end
    end

    private

    def redirect_to_root
      redirect_to(:root)
    end
  end
end
