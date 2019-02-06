# frozen_string_literal: true

require 'test_helper'

module Accounts
  class ProfileSettingsController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      sign_in @user
      @form_params = %w[
        avatar phone_number extension_number website twitter linkedin skype orcid
      ]
    end

    test 'should be able to get /profile path' do
      get profile_path
      assert_response :success
    end

    test 'should be able to view all profile elements on the page' do
      get profile_path
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#user_#{param}"
        end
      end
    end

    test 'should be able to update profile settings' do
      patch profile_path, params: {
        user: {
          phone_number: '3623121919',
          extension_number: '1234',
          website: 'https://www.serhatdundar.com',
          twitter: 'msdundar',
          linkedin: 'msdundar',
          skype: 'msdundar',
          orcid: '1345'
        }
      }

      @user.reload

      assert_equal 'msdundar', @user.twitter

      assert_redirected_to profile_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    private

    def translate(key)
      t("account.profile_settings#{key}")
    end
  end
end
