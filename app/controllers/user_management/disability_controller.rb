# frozen_string_literal: true

module UserManagement
  class DisabilityController < ApplicationController
    before_action :set_user

    def edit; end

    def update
      return redirect_to user_path(@user), notice: t('.success') if @user.update(user_params)

      render :edit
    end

    private

    def set_user
      @user = User.friendly.find(params[:id])
    end

    def authorized?
      authorize(@user || User, policy_class: UserManagement::DisabilityPolicy)
    end

    def user_params
      params.require(:user).permit(:disability_rate)
    end
  end
end
