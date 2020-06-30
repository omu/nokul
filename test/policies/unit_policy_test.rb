# frozen_string_literal: true

require 'pundit_test_case'

class UnitPolicyTest < PunditTestCase
  %w[
    courses?
    create?
    curriculums?
    destroy?
    edit?
    employees?
    index?
    new?
    programs?
    show?
    update?
  ].each do |method|
    test method do
      assert_permit     users(:serhat)
      assert_not_permit users(:mine)
    end
  end
end
