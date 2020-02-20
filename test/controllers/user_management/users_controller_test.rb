# frozen_string_literal: true

require 'test_helper'

module UserManagement
  class UsersControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @user = users(:john)
    end

    test 'should get index' do
      get users_path
      assert_response :success
    end

    test 'should get show' do
      get user_path(@user)
      assert_response :success
    end

    test 'should get edit' do
      get edit_user_path(@user)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update user' do
      user = User.last
      patch user_path(user), params: {
        user: {
          email: 'updated_user@gmail.com'
        }
      }

      user.reload

      assert_equal 'updated_user@gmail.com', user.email
      assert_redirected_to users_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy user' do
      assert_difference('User.count', -1) do
        delete user_path(User.last)
      end

      assert_redirected_to users_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("user_management.users#{key}")
    end
  end
end
