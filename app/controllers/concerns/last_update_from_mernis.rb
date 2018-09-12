# frozen_string_literal: true

module LastUpdateFromMernis
  extend ActiveSupport::Concern

  def elapsed_time(resource)
    elapsed_time = (Time.zone.now - resource.updated_at) / 1.day
    return unless elapsed_time.blank? || elapsed_time < 7

    @user.present? ? redirect_to(@user, notice: t('.wait')) : redirect_with('wait')
  end
end
