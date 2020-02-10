# frozen_string_literal: true

require 'test_helper'

module Activation
  class ActivationServiceTest < ActiveSupport::TestCase
    setup do
      prospective = prospective_students(:mine)

      @activation =
        Activation::ActivationService.new(
          id_number:     prospective.id_number,
          first_name:    prospective.first_name,
          last_name:     prospective.last_name,
          date_of_birth: '1984-11-16',
          document_no:   'A24B48573',
          mobile_phone:  '+905551111111'
        )
    end

    # validations: presence
    %i[
      id_number
      first_name
      last_name
      date_of_birth
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
      assert_equal 9, @activation.document_no.length
      assert_match(/\A\d+\z/, @activation.id_number)
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
  end
end
