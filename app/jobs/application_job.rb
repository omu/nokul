# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  retry_on Savon::HTTPError, wait: :exponentially_longer, attempts: 10, queue: :low
  retry_on Savon::InvalidResponseError do |job, exception|
    # TODO: Use a notifier service here!
  end
  discard_on SocketError
  discard_on IdNumberError
end
