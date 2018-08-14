# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:serhat)
    @user = users(:john)
  end

  test 'should get index' do
    get users_path
    assert_response :success
    assert_select '#add-button', t('users.index.new_user_link')
  end

  test 'should get show' do
    get user_path(@user)
    assert_response :success
  end

  test 'should get new' do
    get new_user_path
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_path params: {
        user: {
          id_number: '33998445768',
          email: 'new_user@gmail.com',
          password: '123456'
        }
      }
    end

    user = User.last

    assert_equal '33998445768', user.id_number
    assert_redirected_to users_path
    assert_equal t('users.create.success'), flash[:notice]
  end

  test 'should get edit' do
    get edit_user_path(@user)
    assert_response :success
    assert_select '.card-header strong', t('users.edit.form_title')
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
    assert_equal translate('users.update.success'), flash[:notice]
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_path(User.last)
    end

    assert_redirected_to users_path
    assert_equal translate('users.destroy.success'), flash[:notice]
  end
end
