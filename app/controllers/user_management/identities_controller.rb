# frozen_string_literal: true

module UserManagement
  class IdentitiesController < ApplicationController
    include UpdateableFromMernis

    before_action :set_user
    before_action :set_identity, only: %i[edit update destroy]
    before_action :can_create_identity?, only: %i[new create]
    before_action only: :save_from_mernis do
      updatable_form_mernis!(
        current_user.identities.active.formal.first,
        redirect_path: @user
      )
    end

    def index
      @identities = @user.identities.order(active: :desc, updated_at: :desc)
      render layout: false
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
      IdentityUpsetService.call(@user, identity, identity_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @identity.destroy ? redirect_with('success') : redirect_with('warning')
    end

    def save_from_mernis
      Kps::IdentitySaveJob.perform_later(@user)

      redirect_with('will_update')
    end

    private

    def can_create_identity?
      return if @user.identities.active.formal.blank?

      redirect_with('error')
    end

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def set_identity
      @identity = @user.identities.informal.find(params[:id])
    end

    def redirect_with(message)
      redirect_to(@user, notice: t(".#{message}"))
    end

    def identity_params
      params.require(:identity).permit(
        :first_name, :last_name, :mothers_name, :fathers_name, :gender, :marital_status, :place_of_birth,
        :date_of_birth, :registered_to
      )
    end
  end
end
