# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CurriculumSemesterCourseControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @curriculum_semester = curriculum_semesters(:one)
      @curriculum_semester_course = @curriculum_semester.curriculum_semester_courses.first
    end

    test 'should get new' do
      get new_curriculum_semester_curriculum_semester_course_path(@curriculum_semester)
      assert_response :success
    end

    test 'should create curriculum' do
      course = @curriculum_semester.available_courses.first
      assert_difference('CurriculumSemesterCourse.count') do
        post curriculum_semester_curriculum_semester_courses_path(
          @curriculum_semester
        ), params: {
          curriculum_semester_course: {
            course_id: course.id, ects: 5
          }
        }
      end

      curriculum_semester_course = CurriculumSemesterCourse.last

      assert_equal course.name, curriculum_semester_course.name
      assert_equal 5.0, curriculum_semester_course.ects
      assert_redirected_to index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_curriculum_semester_curriculum_semester_course_path(
        @curriculum_semester, @curriculum_semester_course
      )
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update curriculum' do
      curriculum_semester_course = CurriculumSemesterCourse.last
      patch curriculum_semester_curriculum_semester_course_path(
        @curriculum_semester, curriculum_semester_course
      ), params: {
        curriculum_semester_course: {
          ects: 10
        }
      }

      curriculum_semester_course.reload

      assert_equal 10, curriculum_semester_course.ects
      assert_redirected_to index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy curriculum' do
      assert_difference('CurriculumSemesterCourse.count', -1) do
        delete curriculum_semester_curriculum_semester_course_path(
          @curriculum_semester, CurriculumSemesterCourse.last
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
      t("course_management.curriculum_semester_courses#{key}")
    end
  end
end
