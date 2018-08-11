# frozen_string_literal: true

module Account
  class ProfileController < ApplicationController
    def edit; end

    def update
      current_user.update_without_password(profile_params) ? redirect_to(profile_path, notice: t('.success')) : render(:edit)
    end

    private

    def profile_params
      params.require(:user).permit(
        :phone_number, :extension_number, :website, :twitter, :linkedin, :skype, :orcid, :public_photo, :public_studies
      )
    end
  end
end
