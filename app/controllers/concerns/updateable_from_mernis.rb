# frozen_string_literal: true

module UpdateableFromMernis
  extend ActiveSupport::Concern

  def updatable_form_mernis!(resource, redirect_path:)
    return true if resource.nil? || elapsed_time(resource) > 7.days

    redirect_to(redirect_path, alert: t('.wait'))
  end

  private

  def elapsed_time(resource)
    Time.zone.now - (resource&.updated_at || Time.now.zone)
  end
end
