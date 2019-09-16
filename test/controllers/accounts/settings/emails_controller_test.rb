# frozen_string_literal: true

require 'test_helper'

module Accounts
  module Settings
    class EmailsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:john)
        sign_in @user
      end

      test 'should get edit' do
        get settings_emails_path
        assert_response :success
        assert_select '.card-header strong', translate('.edit.update_email')
        assert_select '.form-group input.form-control', 2
      end

      test 'should update email' do
        parameters = {
          email:            'sample@gmail.com',
          current_password: 'd61c16acabedeab84f1ad062d7ad948ef3'
        }

        put settings_emails_path, params: { user: parameters }

        @user.reload

        assert_equal @user.email, 'sample@gmail.com'
        assert_equal translate('.update.success'), flash[:notice]
        assert_redirected_to :settings
      end

      private

      def translate(key)
        t("account.settings.emails.#{key}")
      end
    end
  end
end
