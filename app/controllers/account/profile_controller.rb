# frozen_string_literal: true

module Account
  class ProfileController < ApplicationController
    def edit; end

    def update
      if current_user.update_without_password(profile_params)
        redirect_to profile_path, notice: t('.success')
      else
        render(:edit)
      end
    end

    private

    def profile_params
      params.require(:user).permit(
        :avatar, :phone_number, :extension_number, :website, :twitter, :linkedin, :skype, :orcid, :public_photo,
        :public_studies
      )
    end
  end
end
