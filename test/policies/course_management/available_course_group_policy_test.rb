# frozen_string_literal: true

require 'pundit_test_case'

module CourseManagement
  class AvailableCourseGroupPolicyTest < PunditTestCase
    setup do
      @group = available_course_groups(:elective_course_group)
    end

    %w[
      create?
      destroy?
      edit?
      new?
      update?
    ].each do |method|
      test method do
        assert_permit     users(:serhat), record: @group
        assert_not_permit users(:mine), record: @group
      end
    end
  end
end
