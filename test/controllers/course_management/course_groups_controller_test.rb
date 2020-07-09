# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CourseGroupControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course_group = course_groups(:bilgisayar_muhendligi_teknik_secmeli_1)
    end

    test 'should get index' do
      get course_groups_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_course_group_link')
    end

    test 'should get show' do
      get course_group_path(@course_group)
      assert_response :success
    end

    test 'should get new' do
      get new_course_group_path
      assert_response :success
    end

    test 'should create course group' do
      parameters = {
        name:                 'Course Group Test',
        total_ects_condition: 5,
        unit_id:              units(:fen_bilgisi_ogretmenligi_programi).id,
        course_group_type_id: course_group_types(:universite_secmeli).id,
        course_ids:           [courses(:fen_egitiminde_teknolojik_alan_bilgisi).id]
      }

      assert_difference('CourseGroup.count') do
        post course_groups_path, params: { course_group: parameters }
      end

      course_group = CourseGroup.last
      parameters.each do |attribute, value|
        assert_equal value, course_group.public_send(attribute)
      end
      assert_redirected_to course_groups_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_course_group_path(@course_group)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update course group' do
      course_group = CourseGroup.last
      patch course_group_path(course_group),
            params: {
              course_group: { name: 'Course Group Test' }
            }

      course_group.reload

      assert_equal 'Course Group Test', course_group.name
      assert_redirected_to course_groups_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy course group' do
      assert_difference('CourseGroup.count', -1) do
        delete course_group_path(CourseGroup.last)
      end

      assert_redirected_to course_groups_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("course_management.course_groups#{key}")
    end
  end
end
