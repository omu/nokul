# frozen_string_literal: true

module Account
  module Settings
    module Preferences
      class ProfilesController < ApplicationController
        def edit; end

        def update
          return redirect_to profile_path, notice: t('.success') if current_user.update_without_password(user_params)

          render :edit
        end

        private

        def user_params
          params.require(:user).permit(:public_photo, :public_studies)
        end
      end
    end
  end
end
