# frozen_string_literal: true

require 'test_helper'

module Accounts
  class ActivationControllerTest < ActionDispatch::IntegrationTest
    setup do
      @prospective = prospective_students(:mine)
      @form_params = %w[id_number first_name last_name date_of_birth serial serial_no document_no mobile_phone country]
    end

    test 'should get new' do
      get activation_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#activation_#{param}"
        end
      end
    end

    test 'should update activation' do
      parameters = {
        id_number: '56593662552',
        first_name: 'Mine',
        last_name: 'Uraslı',
        date_of_birth: '1984-11-16',
        serial: 'J10',
        serial_no: '94646',
        mobile_phone: '5551111111',
        country: 'TR'
      }

      patch activation_path, params: { activation: parameters }
      assert_redirected_to login_path(locale: I18n.locale)
    end
  end
end
