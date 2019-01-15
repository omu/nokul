# frozen_string_literal: true

require 'test_helper'

module References
  class EvaluationTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @evaluation_type = evaluation_types(:undergraduate_midterm)
    end

    test 'should get index' do
      get evaluation_types_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_evaluation_type_link')
    end

    test 'should get new' do
      get new_evaluation_type_path
      assert_response :success
    end

    test 'should create evaluation type' do
      assert_difference('EvaluationType.count') do
        post evaluation_types_path params: {
          evaluation_type: { name: 'Test evaluation type' }
        }
      end

      evaluation_type = EvaluationType.last

      assert_equal 'Test Evaluation Type', evaluation_type.name
      assert_redirected_to :evaluation_types
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_evaluation_type_path(@evaluation_type)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update evaluation type' do
      evaluation_type = EvaluationType.last
      patch evaluation_type_path(evaluation_type), params: {
        evaluation_type: { name: 'Test evaluation type update' }
      }

      evaluation_type.reload

      assert_equal 'Test Evaluation Type Update', evaluation_type.name
      assert_redirected_to :evaluation_types
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy evaluation type' do
      assert_difference('EvaluationType.count', -1) do
        delete evaluation_type_path(EvaluationType.last)
      end

      assert_redirected_to :evaluation_types
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("references.evaluation_types#{key}")
    end
  end
end
