# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include Patron::Sudoable

  protect_from_forgery with: :reset_session

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_locale
    update_preferred_language if user_signed_in?

    language     = current_user&.preferred_language || locale_params || I18n.default_locale
    I18n.locale  = language
    @pagy_locale = language if user_signed_in?
  end

  def default_url_options
    user_signed_in? ? { locale: nil } : { locale: I18n.locale }
  end

  protected

  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
    payload[:remote_ip] = request.ip
    payload[:user_id] = current_user.try(:id)
  end

  def search_params(model = nil)
    parameters = [:term]
    parameters << model.dynamic_search_keys if model
    params.permit(parameters)
  end

  def locale_params
    params[:locale] && I18n.available_locales.include?(params[:locale].to_sym) ? params[:locale] : nil
  end

  def not_found
    redirect_back(fallback_location: root_path, alert: t('not_found'))
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email])
  end

  private

  def handle_unverified_request
    super
    redirect_back(fallback_location: root_path, alert: t('errors.invalid_authenticity_token'))
  end

  def user_not_authorized(exception)
    flash[:alert] = t(
      "#{exception.policy.class.name.underscore}.#{exception.query}",
      scope:   'pundit',
      default: :default
    )
    redirect_back(fallback_location: root_path)
  end

  def update_preferred_language
    return if locale_params == current_user.preferred_language || locale_params.nil?

    current_user.preferred_language = locale_params
    current_user.save(validate: false)
  end
end
