# frozen_string_literal: true

require 'test_helper'

module Actions
  module User
    module Verification
      class VerifyTest < ActiveSupport::TestCase
        setup do
          @_v = { code: '123456', mobile_phone: '+905411111111' }
        end

        test 'should not verify if the code does not match' do
          REDIS.hset("verification.#{@_v[:mobile_phone]}", { value: @_v[:code], attempt: 0 })

          assert_not Actions::User::Verification::Verify.call(@_v[:mobile_phone], '111111').ok?
        end

        test 'should verify if the code match' do
          REDIS.hset("verification.#{@_v[:mobile_phone]}", { value: @_v[:code], attempt: 0 })

          assert Actions::User::Verification::Verify.call(@_v[:mobile_phone], @_v[:code]).ok?
        end
      end
    end
  end
end
