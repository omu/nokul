# frozen_string_literal: true

require 'test_helper'

module Accounts
  class ProfileSettingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      sign_in @user
    end

    test 'should get index' do
      get profile_path
      assert_response :success
    end

    test 'should upload avatar' do
      image = fixture_file_upload 'valid_png_picture.png'

      patch profile_path, params: {
        user: {
          avatar: image
        }
      }

      assert(@user.avatar.attached?)
      assert_redirected_to profile_path
    end
  end
end
