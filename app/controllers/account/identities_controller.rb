# frozen_string_literal: true

module Account
  class IdentitiesController < ApplicationController
    before_action :set_identity, only: %i[edit update destroy mernis]
    before_action :check_formality, only: %i[edit update destroy]
    before_action :set_formal_identities, only: %i[save_from_mernis]
    before_action :set_elapsed_time, only: %i[save_from_mernis]

    def index
      @identities = current_user.identities
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
      @identity.destroy ? redirect_with('success') : redirect_with('warning')
    end

    def save_from_mernis
      if @elapsed_time.present? && @elapsed_time < 7
        redirect_with('wait')
      else
        KpsIdentitySaveJob.perform_later(current_user)
        redirect_with('will_update')
      end
    end

    private

    def set_formal_identities
      @identities = current_user.identities.formal.present? ? current_user.identities.formal : nil
    end

    def set_elapsed_time
      @elapsed_time = (Time.zone.now - current_user.identities.formal.first.updated_at) / 1.day if @identities.present?
    end

    def check_formality
      redirect_with('warning') if @identity.formal?
    end

    def redirect_with(message)
      redirect_to(identities_path, notice: t(".#{message}"))
    end

    def set_identity
      @identity = current_user.identities.find(params[:id])
    end

    def identity_params
      params.require(:identity).permit(
        :name, :first_name, :last_name, :mothers_name, :fathers_name, :gender, :marital_status, :place_of_birth,
        :date_of_birth, :registered_to
      )
    end
  end
end
