# frozen_string_literal: true

module Patron
  module Sudo
    mattr_accessor :timeout, default: 15.minutes
    mattr_accessor :enabled, default: true

    module_function

    def required_now?(started_at, timeout: nil)
      enabled? && !timed_out?(started_at, timeout: timeout)
    end

    def enabled?
      enabled
    end

    def timed_out?(started_at, timeout: nil)
      return true unless started_at

      DateTime.parse(started_at.to_s) + (timeout || Sudo.timeout) >= Time.current
    end
  end
end
