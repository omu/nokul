# frozen_string_literal: true

require 'test_helper'

module Accounts
  class ProfileSettingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:john)
      sign_in @user
    end

    test 'should get index' do
      get profile_path
      assert_response :success
    end

    test 'should upload avatar' do
      image = fixture_file_upload 'files/valid_png_picture.png'

      patch profile_path, params: {
        user: {
          avatar: image
        }
      }

      assert_equal true, @user.avatar.attached?
      assert_response :success
    end
  end
end
