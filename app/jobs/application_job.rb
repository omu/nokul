# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  if Rails.env.production?
    # :exponentially_longer, applies the wait algorithm of (executions ** 4) + 2
    # (first 3s, then 18s, then 83s, etc)
    retry_on Net::HTTPFatalError, wait: :exponentially_longer, attempts: 10, queue: :low
  end

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  discard_on SocketError

  # Most jobs are safe to ignore if the underlying records are no longer available
  discard_on ActiveJob::DeserializationError
end
