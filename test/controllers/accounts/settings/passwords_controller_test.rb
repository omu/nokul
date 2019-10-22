# frozen_string_literal: true

require 'test_helper'

module Accounts
  module Settings
    class PasswordsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:serhat)
        @password = SecureRandom.hex(15).freeze
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
          password:              @password,
          password_confirmation: @password,
          current_password:      'd61c16acabedeab84f1ad062d7ad948ef3'
        }

        put settings_passwords_path, params: { user: parameters }

        @user.reload

        assert @user.valid_password?(@password)
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
