# frozen_string_literal: true

module LastUpdateFromMernis
  extend ActiveSupport::Concern

  def elapsed_time(resource)
    elapsed_time = (Time.zone.now - resource.updated_at) / 1.day
    redirect_with('wait') if elapsed_time.present? && elapsed_time < 7
  end
end
