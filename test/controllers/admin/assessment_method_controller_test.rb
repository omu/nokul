# frozen_string_literal: true

require 'test_helper'

module Admin
  class AssessmentMethodControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @assessment_method = assessment_methods(:exam)
    end

    test 'should get index' do
      get admin_assessment_methods_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_assessment_method_link')
    end

    test 'should get new' do
      get new_admin_assessment_method_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#assessment_method_name'
      end
    end

    test 'should create assessment method' do
      assert_difference('AssessmentMethod.count') do
        post admin_assessment_methods_path params: {
          assessment_method: { name: 'Test assessment method' }
        }
      end

      assessment_method = AssessmentMethod.last

      assert_equal 'create', @controller.action_name
      assert_equal 'Test Assessment Method', assessment_method.name
      assert_redirected_to :admin_assessment_methods
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_admin_assessment_method_path(@assessment_method)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#assessment_method_name'
      end
    end

    test 'should update assessment method' do
      assessment_method = AssessmentMethod.last
      patch admin_assessment_method_path(assessment_method), params: {
        assessment_method: { name: 'Test assessment method update' }
      }

      assessment_method.reload

      assert_equal 'update', @controller.action_name
      assert_equal 'Test Assessment Method Update', assessment_method.name
      assert_redirected_to :admin_assessment_methods
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy assessment method' do
      assert_difference('AssessmentMethod.count', -1) do
        delete admin_assessment_method_path(assessment_methods(:assessment_method_to_delete))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to :admin_assessment_methods
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("admin.assessment_methods#{key}")
    end
  end
end
