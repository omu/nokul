# frozen_string_literal: true

require 'pundit_test_case'

module CalendarManagement
  class CalendarPolicyTest < PunditTestCase
    %w[
      create?
      destroy?
      duplicate?
      edit?
      index?
      new?
      show?
      units?
      update?
    ].each do |method|
      test method do
        assert_permit     users(:serhat)
        assert_not_permit users(:mine)
      end
    end
  end
end
