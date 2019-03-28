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

      if @activation.active
        redirect_to login_path, notice: t('.success')
      else
        render :new
      end
    end

    def check_user_login
      redirect_to root_path if user_signed_in?
    end
  end
end
