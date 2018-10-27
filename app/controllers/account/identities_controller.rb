# frozen_string_literal: true

module Account
  class IdentitiesController < ApplicationController
    include LastUpdateFromMernis

    before_action :set_user
    before_action :set_identity, only: %i[edit update destroy]
    before_action :set_elapsed_time, only: %i[save_from_mernis]

    def index
      @identities = @user.identities
    end

    def new
      @identity = @user.identities.informal.new
    end

    def edit; end

    def create
      @identity = @user.identities.informal.new(identity_params)
      @identity.save ? redirect_with('success') : render(:new)
    end

    def update
      @identity.update(identity_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @identity.destroy ? redirect_with('success') : redirect_with('warning')
    end

    def save_from_mernis
      Kps::IdentitySaveJob.perform_later(@user)
      redirect_with('will_update')
    end

    private

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def set_identity
      @identity = @user.identities.informal.find(params[:id])
    end

    def set_elapsed_time
      formal_identity = @user.identities.user_identity
      return if formal_identity.blank?

      elapsed_time(formal_identity)
    end

    def redirect_with(message)
      redirect_to(user_identities_path(@user), notice: t(".#{message}"))
    end

    def identity_params
      params.require(:identity).permit(
        :first_name, :last_name, :mothers_name, :fathers_name, :gender, :marital_status, :place_of_birth,
        :date_of_birth, :registered_to
      )
    end
  end
end
