# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CourseUnitGroupControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course_unit_group = course_unit_groups(:one)
    end

    test 'should get index' do
      get course_unit_groups_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_course_unit_group_link')
    end

    test 'should get show' do
      get course_unit_group_path(@course_unit_group)
      assert_response :success
    end

    test 'should get new' do
      get new_course_unit_group_path
      assert_response :success
    end

    test 'should create course unit group' do
      assert_difference('CourseUnitGroup.count') do
        post course_unit_groups_path, params: {
          course_unit_group: { name: 'Course Unit Group Test' }
        }
      end

      course_unit_group = CourseUnitGroup.last

      assert_equal 'Course Unit Group Test', course_unit_group.name
      assert_redirected_to course_unit_groups_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_course_unit_group_path(@course_unit_group)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update course unit group' do
      course_unit_group = CourseUnitGroup.last
      patch course_unit_group_path(course_unit_group),
            params: {
              course_unit_group: { name: 'Course Unit Group Test' }
            }

      course_unit_group.reload

      assert_equal 'Course Unit Group Test', course_unit_group.name
      assert_redirected_to course_unit_groups_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy course unit group' do
      assert_difference('CourseUnitGroup.count', -1) do
        delete course_unit_group_path(CourseUnitGroup.last)
      end

      assert_redirected_to course_unit_groups_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("course_management.course_unit_groups#{key}")
    end
  end
end
