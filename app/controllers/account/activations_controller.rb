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
      check(params, login_path, activation_path)
    end

    private

    def redirect_to_root
      redirect_to(:root)
    end
  end
end
