# frozen_string_literal: true

module Account
  module Settings
    class PasswordsController < ApplicationController
      before_action :set_user

      def edit; end

      def update
        return redirect_to settings_path, notice: t('.success') if @user.update_with_password(user_params)

        render :edit
      end

      private

      def set_user
        @user = current_user
      end

      def user_params
        params.require(:user).permit(:password, :password_confirmation, :current_password)
      end
    end
  end
end
