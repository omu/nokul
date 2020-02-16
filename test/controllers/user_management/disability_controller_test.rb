# frozen_string_literal: true

require 'test_helper'

module UserManagement
  class DisabilityControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @user = users(:john)
    end

    test 'should get edit' do
      get disability_user_path(@user)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update user' do
      user = User.last
      put disability_user_path(user), params: { user: { disability_rate: 30 } }

      user.reload

      assert_equal 30, user.disability_rate
      assert_redirected_to user_path(@user)
      assert_equal translate('.update.success'), flash[:notice]
    end

    private

    def translate(key)
      t("user_management.disability#{key}")
    end
  end
end

