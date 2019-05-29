# frozen_string_literal: true

require 'test_helper'

module Accounts
  class ActivationControllerTest < ActionDispatch::IntegrationTest
    setup do
      @form_params = %w[id_number first_name last_name date_of_birth serial serial_no document_no mobile_phone country]
      @prospective = prospective_students(:mine)
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

    test 'should create activation' do
      post activation_path, params: {
        activation: {
          id_number: @prospective.id_number,
          first_name: @prospective.first_name,
          last_name: @prospective.last_name,
          date_of_birth: '1984-11-16',
          serial: 'J10',
          serial_no: '94646',
          mobile_phone: '5551111111',
          country: 'TR'
        }, format: :js
      }
    end

    test 'should check phone verification' do
      post phone_verification_path, params: {
        phone_verification: {
          prospective_students: @prospective.id,
          prospective_employees: '',
          user: users(:mine).id,
          mobile_phone: '+905551111111'
        }
      }

      assert_redirected_to activation_path({})
      assert_not_empty flash[:alert]
    end
  end
end
