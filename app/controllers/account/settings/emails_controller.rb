# frozen_string_literal: true

module Account
  module Settings
    class EmailsController < ApplicationController
      def edit; end

      def update
        return redirect_to settings_path, notice: t('.success') if current_user.update_with_password(user_params)

        render :edit
      end

      private

      def user_params
        params.require(:user).permit(:email, :current_password)
      end
    end
  end
end
