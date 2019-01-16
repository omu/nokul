# frozen_string_literal: true

require 'test_helper'

module Admin
  class EvaluationTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @evaluation_type = evaluation_types(:undergraduate_midterm)
    end

    test 'should get index' do
      get admin_evaluation_types_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_evaluation_type_link')
    end

    test 'should get new' do
      get new_admin_evaluation_type_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#evaluation_type_name'
      end
    end

    test 'should create evaluation type' do
      assert_difference('EvaluationType.count') do
        post admin_evaluation_types_path params: {
          evaluation_type: { name: 'Test evaluation type' }
        }
      end

      evaluation_type = EvaluationType.last

      assert_equal 'create', @controller.action_name
      assert_equal 'Test Evaluation Type', evaluation_type.name
      assert_redirected_to :admin_evaluation_types
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_admin_evaluation_type_path(@evaluation_type)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#evaluation_type_name'
      end
    end

    test 'should update evaluation type' do
      evaluation_type = EvaluationType.last
      patch admin_evaluation_type_path(evaluation_type), params: {
        evaluation_type: { name: 'Test evaluation type update' }
      }

      evaluation_type.reload

      assert_equal 'update', @controller.action_name
      assert_equal 'Test Evaluation Type Update', evaluation_type.name
      assert_redirected_to :admin_evaluation_types
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy evaluation type' do
      assert_difference('EvaluationType.count', -1) do
        delete admin_evaluation_type_path(EvaluationType.last)
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to :admin_evaluation_types
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("admin.evaluation_types#{key}")
    end
  end
end
