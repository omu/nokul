# frozen_string_literal: true

module Account
  class RegistrationsController < Devise::RegistrationsController
    include PhoneVerification
    layout 'guest', except: %i[edit update]

    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]
    before_action :update_slug, only: :update
    after_action :update_password_change_time, only: :update

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

    # rubocop:disable Metrics/AbcSize
    def phone_verification
      phone = current_user[:mobile_phone] = helpers.phone_parse_with_country(params.dig(:user, :mobile_phone),
                                                                             params.dig(:user, :country)).e164_number

      return respond_to :js unless current_user.valid? && current_user.mobile_phone_changed?

      flash[:alert] = t('errors.system_error') unless Twilio::Verify.send_phone_verification_code(phone).ok?

      respond_to :js
    end

    def update_mobile_phone
      phone = params[:phone_verification][:mobile_phone]
      response = check_verification_code

      return redirect_to_with_twilio_error(response, account_path) unless response.ok?
      return redirect_to account_path, notice: t('.success') if current_user.update(mobile_phone: phone)

      redirect_to account_path, alert: t('errors.system_error')
    end
    # rubocop:enable Metrics/AbcSize

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

    private

    def update_password_change_time
      current_user.update!(password_changed_at: Time.zone.now)
    end

    def update_slug
      # rubocop:disable Lint/UselessAssignment
      slug = nil if params[:email].present?
      # rubocop:enable Lint/UselessAssignment
    end
  end
end
