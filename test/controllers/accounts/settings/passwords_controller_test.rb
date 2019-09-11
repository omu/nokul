# frozen_string_literal: true

require 'test_helper'

module Accounts
  module Settings
    class PasswordsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:serhat)
        sign_in @user
      end

      test 'should get edit' do
        get settings_passwords_path
        assert_response :success
        assert_select '.card-header strong', translate('.edit.change_password')
        assert_select '.form-group input.form-control', 3
      end

      test 'should update password' do
        parameters = {
          password:              '3a540dd482342b65bf840ba716da87eb1e',
          password_confirmation: '3a540dd482342b65bf840ba716da87eb1e',
          current_password:      'd61c16acabedeab84f1ad062d7ad948ef3'
        }

        put settings_passwords_path, params: { user: parameters }

        @user.reload

        assert @user.valid_password?('3a540dd482342b65bf840ba716da87eb1e')
        assert_equal translate('.update.success'), flash[:notice]
        assert_redirected_to :settings
      end

      private

      def translate(key)
        t("account.settings.passwords.#{key}")
      end
    end
  end
end
