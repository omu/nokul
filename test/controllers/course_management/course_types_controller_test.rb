# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CourseTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course_type = course_types(:technical_elective)
    end

    test 'should get index' do
      get course_types_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_course_type_link')
    end

    test 'should get new' do
      get new_course_type_path
      assert_response :success
    end

    test 'should create course type' do
      parameters = {
        name: 'Course Type Test',
        code: 'CTT',
        min_credit: 1
      }

      assert_difference('CourseType.count') do
        post course_types_path, params: { course_type: parameters }
      end

      course_type = CourseType.last
      parameters.each do |attribute, value|
        assert_equal value, course_type.send(attribute)
      end
      assert_redirected_to course_types_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_course_type_path(@course_type)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update course type' do
      course_type = CourseType.last
      parameters = {
        name: 'Course Type Update Test',
        code: 'CTUT',
        min_credit: 2
      }

      patch course_type_path(course_type), params: { course_type: parameters }

      course_type.reload

      parameters.each do |attribute, value|
        assert_equal value, course_type.send(attribute)
      end
      assert_redirected_to course_types_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy course type' do
      assert_difference('CourseType.count', -1) do
        delete course_type_path(CourseType.last)
      end

      assert_redirected_to course_types_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("course_management.course_types#{key}")
    end
  end
end
