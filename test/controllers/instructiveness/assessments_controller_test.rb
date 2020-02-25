# frozen_string_literal: true

require 'test_helper'

module Instructiveness
  class AssessmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:vice_rector)
      @course = available_courses(:elective_course)
      @assessment = course_assessment_methods(:elective_midterm_exam_assessment)
      @course_enrollment = course_enrollments(:johns_enrollment)
    end

    test 'should get show' do
      get given_course_assessment_path(@course, @assessment)
      assert_response :success
    end

    test 'should get edit' do
      get edit_given_course_assessment_path(@course, @assessment)
      assert_response :success
    end

    test 'should update assessment' do
      patch given_course_assessment_path(@course, @assessment), params: {
        course_assessment_method: {
          grades_attributes: {
            '0' => { course_enrollment_id: @course_enrollment.id, point: 50 }
          }
        }
      }

      @assessment.reload
      grade = @assessment.grades.last

      assert @assessment.draft?
      assert_equal @course_enrollment, grade.course_enrollment
      assert_equal 50, grade.point
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should get save' do
      assessment = course_assessment_methods(:elective_midterm_project_assessment)
      get save_given_course_assessment_path(@course, assessment)
      assert_redirected_to given_course_assessment_path(@course, assessment)
      assert_equal translate('.save.success'), flash[:info]
    end

    test 'should get draft' do
      assessment = course_assessment_methods(:elective_midterm_project_assessment)
      assessment.update(status: :saved)
      get draft_given_course_assessment_path(@course, assessment)
      assert_redirected_to given_course_assessment_path(@course, assessment)
      assert_equal translate('.draft.success'), flash[:info]
    end

    private

    def translate(key)
      t("instructiveness.assessments#{key}")
    end
  end
end
