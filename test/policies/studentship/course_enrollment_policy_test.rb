# frozen_string_literal: true

require 'pundit_test_case'

module Studentship
  class CourseEnrollmentPolicyTest < PunditTestCase
    %w[
      create?
      destroy?
      index?
      list?
      new?
      save?
    ].each do |method|
      test method do
        assert_permit     users(:serhat)
        assert_not_permit users(:mine)
      end
    end
  end
end
