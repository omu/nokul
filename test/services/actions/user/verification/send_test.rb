# frozen_string_literal: true

require 'test_helper'

module Actions
  module User
    module Verification
      class SendTest < ActiveSupport::TestCase
        setup do
          @_v = { code: '123456', mobile_phone: '+905412345678' }

          # TODO
        end

        test 'verification code should be changed on every request' do
          # TODO: assert_not_equal @verification.code, @v[:code]
        end

        test 'should not send if sms limit exceeded' do
          # TODO: REDIS.hset("verification_#{@v[:mobile_phone]}", { sent_count: 3 })
          # TODO: assert_not @verification.can_be_sent?
        end
      end
    end
  end
end
