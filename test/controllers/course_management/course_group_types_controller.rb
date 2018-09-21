# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CourseGroupTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course_group_type = course_group_types(:one)
    end

    test 'should get index' do
      get course_group_types_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_course_group_type_link')
    end

    test 'should get new' do
      get new_course_group_type_path
      assert_response :success
    end

    test 'should create course group type' do
      assert_difference('CourseGroupType.count') do
        post course_group_types_path, params: {
          course_group_type: { name: 'Course Group Type Test' }
        }
      end

      course_group_type = CourseGroupType.last

      assert_equal 'Course Group Type Test', course_group_type.name
      assert_redirected_to course_group_types_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_course_group_type_path(@course_group_type)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update course group type' do
      course_group_type = CourseGroupType.last
      patch course_group_type_path(course_group_type),
            params: {
              course_group_type: { name: 'Course Group Type Test' }
            }

      course_group_type.reload

      assert_equal 'Course Group Type Test', course_group_type.name
      assert_redirected_to course_group_types_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy course group type' do
      assert_difference('CourseGroupType.count', -1) do
        delete course_group_type_path(CourseGroupType.last)
      end

      assert_redirected_to course_group_types_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("course_management.course_group_types#{key}")
    end
  end
end
