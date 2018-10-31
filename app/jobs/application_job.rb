# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  if Rails.env.production? || Rails.env.beta?
    # :exponentially_longer, applies the wait algorithm of (executions ** 4) + 2
    # (first 3s, then 18s, then 83s, etc)
    retry_on Net::HTTPFatalError, wait: :exponentially_longer, attempts: 10, queue: :low
  end

  discard_on SocketError
end
