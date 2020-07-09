# frozen_string_literal: true

module Account
  class RegistrationsController < Devise::RegistrationsController
    layout 'guest', except: %i[edit update]

    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]
    before_action :update_slug, only: :update

    # GET /resource/sign_up
    def new
      not_found
    end

    # POST /resource
    def create
      not_found
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    def update
      super
    end

    # DELETE /resource
    def destroy
      not_found
    end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :id_number])
    # end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end

    protected

    def after_update_path_for(_resource)
      settings_path
    end

    private

    def update_slug
      # rubocop:disable Lint/UselessAssignment
      slug = nil if params[:email].present?
      # rubocop:enable Lint/UselessAssignment
    end
  end
end
