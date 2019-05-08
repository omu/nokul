# frozen_string_literal: true

require 'pundit_test_case'

module Patron
  class RolePolicyTest < PunditTestCase
    setup do
      @admin  = patron_roles(:admin)
      @custom = patron_roles(:custom)
    end

    %w[
      index?
      show?
      new?
      create?
    ].each do |method|
      test method do
        assert_permit     users(:serhat), record: @admin
        assert_not_permit users(:mine),   record: @admin
      end
    end

    %w[
      edit?
      update?
      destroy?
    ].each do |method|
      test method do
        assert_permit     users(:serhat), record: @custom
        assert_not_permit users(:serhat), record: @admin
        assert_not_permit users(:mine),   record: @custom
      end
    end
  end
end
