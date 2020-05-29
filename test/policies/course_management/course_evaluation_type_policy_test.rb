# frozen_string_literal: true

require 'pundit_test_case'

module CourseManagement
  class CourseEvaluationTypePolicyTest < PunditTestCase
    setup do
      @evaluation_type = course_evaluation_types(:elective_midterm_evaluation_type)
    end

    %w[
      create?
      destroy?
      edit?
      new?
      update?
    ].each do |method|
      test method do
        assert_permit     users(:serhat), record: @evaluation_type
        assert_not_permit users(:mine), record: @evaluation_type
      end
    end
  end
end
