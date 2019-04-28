# frozen_string_literal: true

require 'pundit_test_case'

module Patron
  class QueryStorePolicyTest < PunditTestCase
    setup do
      @record = patron_query_stores(:unit_scope_muhendislik)
    end

    %w[
      index?
      show?
      new?
      create?
      edit?
      update?
      destroy?
      preview?
    ].each do |method|
      test method do
        assert_permit     users(:serhat), record: @record
        assert_not_permit users(:mine),   record: @record
      end
    end
  end
end
