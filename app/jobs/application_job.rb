# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  if Rails.env.production? || Rails.env.beta?
    retry_on Savon::HTTPError, wait: :exponentially_longer, attempts: 10, queue: :low
    retry_on Savon::InvalidResponseError do |job, exception|
      # TODO: Use a notifier service here!
    end
  end
  discard_on SocketError
  discard_on IdNumberError
end
