# frozen_string_literal: true

require 'test_helper'

module Actions
  module User
    module Verification
      class SendTest < ActiveSupport::TestCase
        setup do
          @_v = { code: '123456', mobile_phone: '+905411111111' }
        end

        test 'should not send if sms limit exceeded' do
          REDIS.hset("verification.#{@_v[:mobile_phone]}", { value: @_v[:code], attempt: 2 })

          result = Actions::User::Verification::Send.call(@_v[:mobile_phone])
          assert_includes(result.errors[:base], t('verification.too_many_requests'))
        end
      end
    end
  end
end
