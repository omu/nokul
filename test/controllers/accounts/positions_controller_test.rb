# frozen_string_literal: true

require 'test_helper'

module Accounts
  class PositionsController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      @administrative_function = administrative_functions(:yok_member)
      @duty = duties(:baum)
      sign_in @user
    end

    test 'should get new' do
      get new_user_position_path(@user)
      assert_response :success
    end

    test 'should create position' do
      assert_difference('@user.positions.count') do
        post user_positions_path(@user), params: {
          position: {
            administrative_function_id: @administrative_function.id, duty_id: @duty.id,
            start_date: '01.01.2013', end_date: '01.01.2015'
          }
        }
      end

      position = @user.positions.last

      assert_equal @administrative_function, position.administrative_function
      assert_equal @duty, position.duty

      assert_redirected_to user_path(@user)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should update position' do
      position = @user.positions.first

      patch user_position_path(@user, position), params: {
        position: {
          duty_id: @duty.id, administrative_function_id: @administrative_function.id
        }
      }

      position.reload

      assert_equal @duty, position.duty
      assert_equal @administrative_function, position.administrative_function

      assert_redirected_to user_path(@user)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy position' do
      assert_difference('@user.positions.count', -1) do
        delete user_position_path(@user, @user.positions.last)
      end

      assert_redirected_to user_path(@user)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("account.positions#{key}")
    end
  end
end
