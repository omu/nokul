# frozen_string_literal: true

module Sms
  module Nexmo
    module Api
      module ErrorHandler
        SOFT_FAIL_CODES = {
          '2' => 'Missing Parameters',
          '3' => 'Invalid Parameters',
          '6' => 'Invalid Message',
          '12' => 'Message Too Long',
          '22' => 'Invalid Network Code',
          '33' => 'Number De-activated'
        }.freeze

        HARD_FAIL_CODES = {
          '1' => 'Throttled',
          '4' => 'Invalid Credentials',
          '5' => 'Internal Error',
          '7' => 'Number Barred',
          '8' => 'Partner Account Barred',
          '9' => 'Partner Quota Violation',
          '10' => 'Too Many Existing Binds',
          '11' => 'Account Not Enabled For HTTP',
          '14' => 'Invalid Signature',
          '15' => 'Invalid Sender Address',
          '23' => 'Invalid Callback Url',
          '32' => 'Signature And API Secret Disallowed'
        }.freeze

        def log_or_notify_admin(response)
          status = response.status
          notifier = Slack::Notifier.new Tenant.credentials.slack[:panik_hook]

          if status == '0'
            Rails.logger.info "Sent message id=#{response.message_id}"
          elsif SOFT_FAIL_CODES.key?(status) || HARD_FAIL_CODES.key?(status)
            notifier.ping "Nexmo SMS Error (code: #{status}, text: #{response.error_text})"
          end
        end
      end
    end
  end
end
