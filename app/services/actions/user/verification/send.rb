# frozen_string_literal: true

module Actions
  module User
    module Verification
      class Send < Base
        def run
          phone.send
        rescue Phone::TooManySendRequestError
          result.error(:base, I18n.t('.verification.too_many_requests'))
        rescue SMS::Error => e
          result.error(:base, I18n.t('.verification.error_sending_sms', message: e.message))
        end
      end
    end
  end
end
