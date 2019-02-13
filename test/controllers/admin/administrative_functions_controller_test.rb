# frozen_string_literal: true

require 'test_helper'

module Admin
  class AdministrativeFunctionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @administrative_function = administrative_functions(:dean)
    end

    test 'should get index' do
      get admin_administrative_functions_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_administrative_function_link')
    end

    test 'should get new' do
      get new_admin_administrative_function_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#administrative_function_name'
      end
    end

    test 'should create assessment method' do
      assert_difference('AdministrativeFunction.count') do
        post admin_administrative_functions_path params: {
          administrative_function: { name: 'Test assessment method', code: 1234 }
        }
      end

      administrative_function = AdministrativeFunction.last

      assert_equal 'create', @controller.action_name
      assert_equal 'Test Assessment Method', administrative_function.name
      assert_redirected_to %i[admin administrative_functions]
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_admin_administrative_function_path(@administrative_function)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#administrative_function_name'
      end
    end

    test 'should update assessment method' do
      administrative_function = AdministrativeFunction.last
      patch admin_administrative_function_path(administrative_function), params: {
        administrative_function: { name: 'Test assessment method update' }
      }

      administrative_function.reload

      assert_equal 'update', @controller.action_name
      assert_equal 'Test Assessment Method Update', administrative_function.name
      assert_redirected_to %i[admin administrative_functions]
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy assessment method' do
      assert_difference('AdministrativeFunction.count', -1) do
        delete admin_administrative_function_path(administrative_functions(:administrative_function_to_delete))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to %i[admin administrative_functions]
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("admin.administrative_functions#{key}")
    end
  end
end
