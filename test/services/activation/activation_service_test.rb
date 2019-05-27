# frozen_string_literal: true

require 'test_helper'

module Activation
  class ActivationServiceTest < ActiveSupport::TestCase
    setup do
      prospective = prospective_students(:mine)

      @activation =
        Activation::ActivationService.new(
          id_number: prospective.id_number,
          first_name: prospective.first_name,
          last_name: prospective.last_name,
          date_of_birth: '1984-11-16',
          serial: 'J10',
          serial_no: '94646',
          mobile_phone: '5551111111',
          country: 'TR'
        )
    end

    # validations: presence
    %i[
      id_number
      first_name
      last_name
      date_of_birth
      country
      mobile_phone
    ].each do |property|
      test "#{property} of activation can not be nil" do
        @activation.send("#{property}=", nil)
        assert_not @activation.valid?
        assert_not_empty @activation.errors[property]
      end
    end

    # validations: numericality and length
    test 'check numericality and length validations' do
      assert_equal 11, @activation.id_number.length
      assert_equal 3, @activation.serial.length
      assert @activation.id_number.match(/\A\d+\z/)
      assert @activation.serial_no.match(/\A\d+\z/)
    end

    test 'phone number must be checked with country' do
      @activation.country = 'DE'
      assert_not @activation.valid?
      assert_not_empty @activation.errors[:mobile_phone]
    end

    test 'user must not be activated' do
      assert_not @activation.activated?
    end

    test 'student must be prospective' do
      assert @activation.prospective?
    end

    test 'student must be verified identity' do
      assert @activation.verified_identity?
    end

    test 'must be send verification code' do
      assert @activation.send_verification_code?
    end

    {
      '70336212330' => 'record_not_found',
      '10570898198' => 'already_activated'
    }.each do |id_number, error_key|
      test "check for faulty #{id_number}" do
        fake = @activation.dup
        fake.id_number = id_number
        assert_not fake.active
        assert_not_empty fake.errors[:base]
        assert_equal I18n.t('.account.activations.' + error_key), fake.errors[:base].first
      end
    end

    test 'activation is must be active' do
      assert @activation.active
      assert_not_nil @activation.prospective_student || @activation.prospective_employee
      assert_not_nil @activation.user
    end
  end
end
