# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CourseEvaluationCriterionTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @criterion_type = course_evaluation_criterion_types(:exam)
    end

    test 'should get index' do
      get course_evaluation_criterion_types_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_course_evaluation_criterion_type_link')
    end

    test 'should get new' do
      get new_course_evaluation_criterion_type_path
      assert_response :success
    end

    test 'should create course criterion type' do
      assert_difference('CourseEvaluationCriterionType.count') do
        post course_evaluation_criterion_types_path, params: {
          course_evaluation_criterion_type: {
            name: 'Test Ders Kriteri', identifier: 'test'
          }
        }
      end

      criterion_type = CourseEvaluationCriterionType.last

      assert_equal 'Test Ders Kriteri', criterion_type.name
      assert_equal 'test', criterion_type.identifier
      assert_redirected_to course_evaluation_criterion_types_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_course_evaluation_criterion_type_path(@criterion_type)
      assert_response :success
      assert_select '.simple_form' do
        assert_select '#course_evaluation_criterion_type_name'
        assert_select '#course_evaluation_criterion_type_identifier'
      end
    end

    test 'should update course criterion type' do
      criterion_type = CourseEvaluationCriterionType.last
      patch course_evaluation_criterion_type_path(criterion_type), params: {
        course_evaluation_criterion_type: {
          name: 'Test Ders Kriter Update'
        }
      }

      criterion_type.reload

      assert_equal 'Test Ders Kriter Update', criterion_type.name
      assert_redirected_to course_evaluation_criterion_types_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy course criterion type' do
      assert_difference('CourseEvaluationCriterionType.count', -1) do
        delete course_evaluation_criterion_type_path(@criterion_type)
      end

      assert_redirected_to course_evaluation_criterion_types_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("course_management.course_evaluation_criterion_types#{key}")
    end
  end
end
