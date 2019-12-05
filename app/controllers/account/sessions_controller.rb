# frozen_string_literal: true

module Account
  class SessionsController < Devise::SessionsController
    layout 'guest'
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
      if ENV.fetch('NOKUL_SSO_ENABLED', false)
        redirect_to(user_openid_connect_omniauth_authorize_path)
      else
        super
      end
    end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    protected

    def after_sign_out_path_for(_resource_or_scope)
      login_path
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
