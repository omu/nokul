# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CourseEvaluationTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course_evaluation_type = course_evaluation_types(:ati_midterm_evaluation_type)
      @available_course = available_courses(:ati_fall_2018_2019)
      @evaluation_type = evaluation_types(:undergraduate_retake)
    end

    test 'should get new' do
      get new_available_course_evaluation_type_path(@available_course)
      assert_response :success
    end

    test 'should create course evaluation type' do
      available_course = available_courses(:test_fall_2018_2019)
      parameters = {
        available_course_id:                  available_course.id,
        evaluation_type_id:                   @evaluation_type.id,
        percentage:                           60,
        course_assessment_methods_attributes: {
          '0' => {
            assessment_method_id: assessment_methods(:exam).id,
            percentage:           100
          }
        }
      }
      assert_difference('CourseEvaluationType.count') do
        post available_course_evaluation_types_path(available_course),
             params: { course_evaluation_type: parameters }
      end

      course_evaluation_type = CourseEvaluationType.last

      assert_equal available_course, course_evaluation_type.available_course
      assert_equal @evaluation_type, course_evaluation_type.evaluation_type
      assert_equal 60, course_evaluation_type.percentage
      assert_redirected_to available_course_path(available_course)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_available_course_evaluation_type_path(@available_course, @course_evaluation_type)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update course evaluation type' do
      course_evaluation_type = CourseEvaluationType.last
      available_course = course_evaluation_type.available_course
      patch available_course_evaluation_type_path(available_course, course_evaluation_type),
            params: {
              course_evaluation_type: {
                percentage:                           60,
                course_assessment_methods_attributes: {
                  '0' => {
                    assessment_method_id: assessment_methods(:exam).id,
                    percentage:           100
                  }
                }
              }
            }

      course_evaluation_type.reload

      assert_equal 60, course_evaluation_type.percentage
      assert_redirected_to available_course_path(available_course)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy course evaluation type' do
      assert_difference('CourseEvaluationType.count', -1) do
        delete available_course_evaluation_type_path(@available_course, evaluation_types(:evaluation_type_to_delete))
      end

      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("course_management.course_evaluation_types#{key}", course: @available_course.name)
    end
  end
end
