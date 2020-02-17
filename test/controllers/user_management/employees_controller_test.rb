# frozen_string_literal: true

require 'test_helper'

module UserManagement
  class EmployeesControllerTest < ActionDispatch::IntegrationTest
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
            title_id: @title.id, staff_number: 'A1000', active: false
          }
        }
      end

      employee = @user.employees.last

      assert_equal @title, employee.title
      assert_equal 'A1000', employee.staff_number
      assert_not employee.active

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
      assert_not employee.active

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
      t("user_management.employees#{key}")
    end
  end
end
