# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CourseEvaluationTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course_evaluation_type = course_evaluation_types(:elective_midterm_evaluation_type)
      @available_course = @course_evaluation_type.available_course
    end

    test 'should get new' do
      get new_available_course_evaluation_type_path(@available_course)
      assert_response :success
    end

    test 'should create course evaluation type' do
      assert_difference('CourseEvaluationType.count') do
        post available_course_evaluation_types_path(@available_course), params: create_params
      end

      course_evaluation_type = CourseEvaluationType.last

      assert_equal @available_course, course_evaluation_type.available_course
      assert_equal evaluation_types(:undergraduate_final), course_evaluation_type.evaluation_type
      assert_equal 60, course_evaluation_type.percentage
      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should not create course evaluation type when event is not active' do
      deactivate_event
      assert_no_difference('CourseEvaluationType.count') do
        post available_course_evaluation_types_path(@available_course), params: create_params
      end

      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.errors.not_proper_event_range'), flash[:notice]
    end

    test 'should get edit' do
      get edit_available_course_evaluation_type_path(@available_course, @course_evaluation_type)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update course evaluation type' do
      patch available_course_evaluation_type_path(@available_course, @course_evaluation_type),
            params: {
              course_evaluation_type: {
                percentage:                           60,
                course_assessment_methods_attributes: {
                  '0' => {
                    assessment_method_id: assessment_methods(:lab).id,
                    percentage:           10
                  }
                }
              }
            }

      @course_evaluation_type.reload

      assert_equal 60, @course_evaluation_type.percentage
      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy course evaluation type' do
      course_evaluation_type = course_evaluation_types(:course_evaluation_type_to_delete)
      available_course = course_evaluation_type.available_course

      assert_difference('CourseEvaluationType.count', -1) do
        delete available_course_evaluation_type_path(available_course, course_evaluation_type)
      end

      assert_redirected_to available_course_path(available_course)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    test 'should not destroy course evaluation type when event is not active' do
      deactivate_event
      course_evaluation_type = course_evaluation_types(:course_evaluation_type_to_delete)
      available_course = course_evaluation_type.available_course

      assert_no_difference('CourseEvaluationType.count') do
        delete available_course_evaluation_type_path(available_course, course_evaluation_type)
      end

      assert_redirected_to root_path
      assert_equal t('pundit.default'), flash[:alert]
    end

    private

    def deactivate_event
      event = @available_course.unit.calendars.active.last.event('add_drop_available_courses')
      event.update(end_time: Time.zone.now - 1.day)
    end

    def create_params
      {
        course_evaluation_type: {
          available_course_id:                  @available_course.id,
          evaluation_type_id:                   evaluation_types(:undergraduate_final).id,
          percentage:                           60,
          course_assessment_methods_attributes: {
            '0' => { assessment_method_id: assessment_methods(:exam).id, percentage: 100 }
          }
        }
      }
    end

    def translate(key)
      t("course_management.course_evaluation_types#{key}", course: @available_course.name)
    end
  end
end
