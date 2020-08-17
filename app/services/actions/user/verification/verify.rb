# frozen_string_literal: true

module Actions
  module User
    module Verification
      class Verify < Base
        def call(code)
          result.accordingly { phone.verify?(code) }
        rescue Phone::MissingVerifyRecordError
          result.error(:base, I18n.t('.verification.without_any_record'))
        end
      end
    end
  end
end
