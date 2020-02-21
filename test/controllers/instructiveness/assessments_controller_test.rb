# frozen_string_literal: true

require 'test_helper'

module Instructiveness
  class AssessmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course = available_courses(:elective_course)
      @assessment = course_assessment_methods(:elective_midterm_exam_assessment)
      @course_enrollment = course_enrollments(:johns_enrollment)
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

    private

    def translate(key)
      t("instructiveness.assessments#{key}")
    end
  end
end
