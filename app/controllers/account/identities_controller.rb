# frozen_string_literal: true

module Account
  class IdentitiesController < ApplicationController
    include LastUpdateFromMernis

    before_action :set_identity, only: %i[edit update destroy]
    before_action :set_elapsed_time, only: %i[save_from_mernis]
    before_action :check_existing_identities, only: %i[new create]

    def index
      @identities = current_user.identities.order(:type)
    end

    def new
      @identity = current_user.identities.informal.new
    end

    def edit; end

    def create
      @identity = current_user.identities.informal.new(identity_params)
      @identity.save ? redirect_with('success') : render(:new)
    end

    def update
      @identity.update(identity_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      if @identity.destroy
        redirect_with('success')
      else
        redirect_to(identities_path, alert: t('.warning'))
      end
    end

    def save_from_mernis
      Kps::IdentitySaveJob.perform_later(current_user)
      redirect_with('will_update')
    end

    private

    def set_identity
      @identity = current_user.identities.informal.find(params[:id])
    end

    def set_elapsed_time
      formal_identity = current_user.identities.user_identity
      return if formal_identity.blank?

      elapsed_time(formal_identity)
    end

    def check_existing_identities
      identities = current_user.identities
      redirect_to :identities, notice: t('.already_have_identity') if identities.present?
    end

    def redirect_with(message)
      redirect_to(identities_path, notice: t(".#{message}"))
    end

    def identity_params
      params.require(:identity).permit(
        :first_name, :last_name, :mothers_name, :fathers_name, :gender, :marital_status, :place_of_birth,
        :date_of_birth, :registered_to
      )
    end
  end
end
