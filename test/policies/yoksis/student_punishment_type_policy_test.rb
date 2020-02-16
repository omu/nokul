# frozen_string_literal: true

require 'pundit_test_case'

module Yoksis
  class StudentPunishmentTypePolicyTest < PunditTestCase
    %w[
      create?
      destroy?
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
