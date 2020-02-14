# frozen_string_literal: true

module Account
  class IdentitiesController < ApplicationController
    include UpdateableFromMernis

    before_action only: :save_from_mernis do
      updatable_form_mernis!(
        current_user.identities.active.formal.first,
        redirect_path: settings_path
      )
    end

    def index
      @identities = current_user.identities.order(active: :desc, updated_at: :desc)
    end

    def save_from_mernis
      Kps::IdentitySaveJob.perform_later(current_user)

      redirect_to :settings, notice: t('.will_update')
    end
  end
end
