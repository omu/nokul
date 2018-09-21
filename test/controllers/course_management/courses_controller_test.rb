# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course = courses(:ati)
    end

    test 'should get index' do
      get courses_path
      assert_response :success
      assert_select '#add-button', translate('.index.add_new_course')
      assert_select '#collapseSmartSearchLink', t('smart_search')
      assert_select '#collapseDetailedSearchLink', t('detailed_search')
    end

    test 'should get show' do
      get course_path(@course)
      assert_response :success
    end

    test 'should get new' do
      get new_course_path
      assert_response :success
    end

    test 'should create course' do
      assert_difference('Course.count') do
        post courses_path, params: {
          course: {
            name: 'Test Controller Course', code: 'TTC', theoric: 3, practice: 0,
            laboratory: 0, unit_id: units(:omu).id, program_type: :undergraduate,
            language_id: languages(:turkce).id, status: :active
          }
        }
      end

      course = Course.last

      assert_equal 'Test Controller Course', course.name
      assert_equal 3.0, course.credit.to_f
      assert_equal 'undergraduate', course.program_type
      assert_equal units(:omu), course.unit
      assert course.active?
      assert_redirected_to courses_path
      assert_equal translate('.create.success'), flash[:info]
    end

    test 'should get edit' do
      get edit_course_path(@course)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update course' do
      course = Course.last
      patch course_path(course), params: {
        course: {
          name: 'Test Course Update', code: 'TTCU', theoric: 4, practice: 2
        }
      }

      course.reload

      assert_equal 'Test Course Update', course.name
      assert_equal 5.0, course.credit.to_f
      assert_redirected_to courses_path
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should destroy course' do
      assert_difference('Course.count', -1) do
        delete course_path(Course.unscope(:order).last)
      end

      assert_redirected_to courses_path
      assert_equal translate('.destroy.success'), flash[:info]
    end

    private

    def translate(key)
      t("course_management.courses#{key}")
    end
  end
end
