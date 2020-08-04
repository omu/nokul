# frozen_string_literal: true

require 'test_helper'

module Account
  class PasswordRecoveryControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:john)
    end

    test 'should get new' do
      get password_recovery_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#password_recovery_id_number'
        assert_select '#password_recovery_mobile_phone'
      end
    end

    test 'should not get password_recovery_update_path without signed_id' do
      get password_recovery_update_path
      assert_response :redirect
      assert_redirected_to password_recovery_path(locale: 'tr')
    end

    test 'should not redirect to new password screen with unmatch informations' do
      post password_recovery_path, params: {
        password_recovery: {
          id_number:    @user.id_number,
          mobile_phone: '+905551111110' # wrong phone number
        }
      }

      assert_select '.list-group-item-danger', I18n.t('.account.password_recovery.no_matching_user')
    end
  end
end
