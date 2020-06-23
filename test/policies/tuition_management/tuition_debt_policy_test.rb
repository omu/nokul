# frozen_string_literal: true

require 'pundit_test_case'

module TuitionManagement
  class TuitionDebtPolicyTest < PunditTestCase
    %w[
      create?
      create_with_service?
      destroy?
      edit?
      index?
      new?
      update?
    ].each do |method|
      test method do
        assert_permit     users(:serhat)
        assert_not_permit users(:mine)
      end
    end
  end
end
