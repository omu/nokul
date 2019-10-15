# frozen_string_literal: true

require 'test_helper'

module Accounts
  class DutiesController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      @unit = units(:cbu)
      sign_in @user
    end

    test 'should get new' do
      get new_user_duty_path(@user)
      assert_response :success
    end

    test 'should create duty' do
      assert_difference('@user.duties.count') do
        post user_duties_path(@user), params: {
          duty: {
            employee_id: employees(:serhat_active).id, unit_id: @unit.id, temporary: true, start_date: '01.09.2018'
          }
        }
      end

      duty = @user.duties.last

      assert_equal employees(:serhat_active), duty.employee
      assert_equal @unit, duty.unit
      assert(duty.temporary)

      assert_redirected_to user_path(@user)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should update duty' do
      duty = @user.duties.first

      patch user_duty_path(@user, duty), params: {
        duty: {
          unit_id: @unit.id, temporary: true
        }
      }

      duty.reload

      assert_equal @unit, duty.unit
      assert(duty.temporary)

      assert_redirected_to user_path(@user)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy duty' do
      assert_difference('@user.duties.count', -1) do
        delete user_duty_path(@user, @user.duties.last)
      end

      assert_redirected_to user_path(@user)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("account.duties#{key}")
    end
  end
end
