# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  breadcrumb I18n.t('home_nav'), :root_path

  def set_locale
    language = language_params

    if user_signed_in?
      current_user.update(preferred_language: language) if language
      I18n.locale = current_user.preferred_language
    else
      I18n.locale = language || I18n.default_locale
    end
  end

  def default_url_options
    user_signed_in? ? { locale: nil } : { locale: I18n.locale }
  end

  protected

  def language_params
    params[:locale] && I18n.available_locales.include?(params[:locale].to_sym) ? params[:locale] : nil
  end

  def not_found
    redirect_back(fallback_location: root_path, alert: t('not_found'))
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[id_number email])
  end
end
