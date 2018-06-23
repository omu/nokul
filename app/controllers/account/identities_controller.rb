# frozen_string_literal: true

module Account
  class IdentitiesController < ApplicationController
    before_action :set_identity, only: %i[edit update destroy mernis]
    before_action :check_formality, only: %i[edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index new edit]

    def index
      @identities = current_user.identities
    end

    def new
      breadcrumb t('.form_title'), identities_path
      @identity = current_user.identities.informal.new
    end

    def edit
      breadcrumb t('.form_title'), identities_path
    end

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

    def mernis
      if (Time.zone.now - @identity.updated_at) / 1.day < 7
        redirect_with('wait')
      else
        # TODO: KpsIdentityUpdateJob.perform_later(identity)
        redirect_with('will_update')
      end
    end

    private

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), identities_path, match: :exact
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
