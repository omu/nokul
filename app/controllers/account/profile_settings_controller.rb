# frozen_string_literal: true

module Account
  class ProfileSettingsController < ApplicationController
    # before_action :purge_avatar, only: :update

    def edit; end

    def update
      if current_user.update_without_password(profile_params)
        redirect_to profile_path, notice: t('.success')
      else
        render(:edit)
      end
    end

    private

    # def purge_avatar
    #   current_user.avatar.purge
    # end

    def profile_params
      params.require(:user).permit(
        :avatar, :country, :phone_number, :extension_number, :website, :twitter, :linkedin, :skype, :orcid,
        :public_photo, :public_studies
      )
    end
  end
end
