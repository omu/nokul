# frozen_string_literal: true

require 'test_helper'

class PasswordRecoveryServiceTest < ActiveSupport::TestCase
  setup do
    user = users(:john)

    @password_recovery =
      PasswordRecoveryService.new(
        id_number:    user.id_number,
        mobile_phone: user.mobile_phone
      )
  end

  # validations: presence
  %i[
    id_number
    mobile_phone
  ].each do |property|
    test "#{property} of password recovery can not be nil" do
      @password_recovery.public_send("#{property}=", nil)
      assert_not @password_recovery.valid?
      assert_not_empty @password_recovery.errors[property]
    end
  end

  # validations: numericality and length
  test 'check numericality and length validations' do
    assert_equal 11, @password_recovery.id_number.length
    assert_match(/\A\d+\z/, @password_recovery.id_number)
  end

  test 'phone number must be checked with country' do
    @password_recovery.country = 'DE'
    assert_not @password_recovery.valid?
    assert_not_empty @password_recovery.errors[:mobile_phone]
  end

  test 'Id number and mobile phone should match' do
    @password_recovery.id_number = '12345678901'

    assert_not @password_recovery.valid?
  end
end
