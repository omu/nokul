# frozen_string_literal: true

require 'pundit_test_case'

module CourseManagement
  class AvailableCoursePolicyTest < PunditTestCase
    setup do
      @available_course = available_courses(:elective_course)
    end

    %w[
      create?
      destroy?
      edit?
      index?
      new?
      show?
      update?
    ].each do |method|
      test method do
        assert_permit     users(:serhat), record: @available_course
        assert_not_permit users(:mine), record: @available_course
      end
    end
  end
end
