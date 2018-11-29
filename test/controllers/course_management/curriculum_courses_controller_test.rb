# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CurriculumCoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @curriculum_semester = curriculum_semesters(:one)
      @curriculum_course = @curriculum_semester.curriculum_courses.first
    end

    test 'should get new' do
      get new_curriculum_semester_curriculum_course_path(@curriculum_semester)
      assert_response :success
    end

    test 'should create curriculum' do
      course = @curriculum_semester.available_courses.first
      assert_difference('CurriculumCourse.count') do
        post curriculum_semester_curriculum_courses_path(
          @curriculum_semester
        ), params: {
          curriculum_course: {
            course_id: course.id, ects: 5
          }
        }
      end

      curriculum_course = CurriculumCourse.last

      assert_equal course.name, curriculum_course.name
      assert_equal 5.0, curriculum_course.ects
      assert_redirected_to index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_curriculum_semester_curriculum_course_path(
        @curriculum_semester, @curriculum_course
      )
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update curriculum' do
      curriculum_course = CurriculumCourse.last
      patch curriculum_semester_curriculum_course_path(
        @curriculum_semester, curriculum_course
      ), params: {
        curriculum_course: {
          ects: 10
        }
      }

      curriculum_course.reload

      assert_equal 10, curriculum_course.ects
      assert_redirected_to index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy curriculum' do
      assert_difference('CurriculumCourse.count', -1) do
        delete curriculum_semester_curriculum_course_path(
          @curriculum_semester, CurriculumCourse.last
        )
      end

      assert_redirected_to index_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def index_path
      curriculum_path(@curriculum_semester.curriculum)
    end

    def translate(key)
      t("course_management.curriculum_courses#{key}")
    end
  end
end
