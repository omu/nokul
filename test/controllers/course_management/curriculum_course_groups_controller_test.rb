# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CurriculumCourseGroupsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @curriculum_semester = CurriculumSemesterDecorator.new(
        curriculum_semesters(:bm_first)
      )
      @curriculum_course_group = @curriculum_semester.curriculum_course_groups.first
    end

    test 'should get new' do
      get new_curriculum_semester_curriculum_course_group_path(@curriculum_semester)
      assert_response :success
    end

    test 'should create curriculum course group' do
      parameters = {
        course_group_id: @curriculum_semester.selectable_course_groups.first.id, ects: 5
      }
      assert_difference('CurriculumCourseGroup.count') do
        post curriculum_semester_curriculum_course_groups_path(
          @curriculum_semester
        ), params: { curriculum_course_group: parameters }
      end

      curriculum_course_group = CurriculumCourseGroup.last
      parameters.each do |attribute, value|
        assert_equal value, curriculum_course_group.public_send(attribute)
      end
      assert_redirected_to index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_curriculum_semester_curriculum_course_group_path(
        @curriculum_semester, @curriculum_course_group
      )
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update curriculum course group' do
      curriculum_course_group = CurriculumCourseGroup.last
      patch curriculum_semester_curriculum_course_group_path(
        @curriculum_semester, curriculum_course_group
      ), params: { curriculum_course_group: { ects: 10 } }

      curriculum_course_group.reload

      assert_equal 10, curriculum_course_group.ects
      assert_redirected_to index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy curriculum course group' do
      assert_difference('CurriculumCourseGroup.count', -1) do
        delete curriculum_semester_curriculum_course_group_path(
          @curriculum_semester, CurriculumCourseGroup.last
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
      t("course_management.curriculum_course_groups#{key}")
    end
  end
end
