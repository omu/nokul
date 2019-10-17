# frozen_string_literal: true

module Patron
  class ConfirmationsController < ApplicationController
    layout 'guest'

    def create
      if current_user.valid_password?(secure_params[:password])
        extend_sudo_session!
        redirect_to secure_params[:return_to]
      else
        flash[:alert] = t('.error')
        render :new
      end
    end

    private

    def secure_params
      params.require(:sudo).permit(:password, :return_to)
    end
  end
end
