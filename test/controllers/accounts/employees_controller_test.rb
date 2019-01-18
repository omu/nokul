# frozen_string_literal: true

require 'test_helper'

module Accounts
  class EmployeesController < ActionDispatch::IntegrationTest
    setup do
      @user = users(:serhat)
      @title = titles(:chief)
      sign_in @user
    end

    test 'should get new' do
      get new_user_employee_path(@user)
      assert_response :success
    end

    test 'should create employee' do
      assert_difference('@user.employees.count') do
        post user_employees_path(@user), params: {
          employee: {
            title_id: @title.id, active: false
          }
        }
      end

      employee = @user.employees.last

      assert_equal @title, employee.title
      assert_equal false, employee.active

      assert_redirected_to user_path(@user)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should update employee' do
      employee = @user.employees.first

      patch user_employee_path(@user, employee), params: {
        employee: {
          title_id: @title.id, active: false
        }
      }

      employee.reload

      assert_equal @title, employee.title
      assert_equal false, employee.active

      assert_redirected_to user_path(@user)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy employee' do
      user = users(:john)
      assert_difference('user.employees.count', -1) do
        delete user_employee_path(user, employees(:employee_to_delete))
      end

      assert_redirected_to user_path(user)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("account.employees#{key}")
    end
  end
end
