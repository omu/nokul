# frozen_string_literal: true

module Account
  class ActivationsController < ApplicationController
    before_action :check_user_login
    skip_before_action :authenticate_user!
    layout 'guest'

    def new
      @activation = Activatable::ActivationService.new
    end

    def update
      @activation = Activatable::ActivationService.new(params[:activation])
      if @activation.valid?
        @activation.prospective.update(archived: true)
        @activation.user.update(activated: true, activated_at: Time.zone.now)
        redirect_to login_path, notice: 'Hesabınız aktifleştirildi.'
      else
        render :new
      end
    end

    def check_user_login
      redirect_to root_path if user_signed_in?
    end
  end
end
