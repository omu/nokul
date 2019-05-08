# frozen_string_literal: true

require 'pundit_test_case'

module Patron
  class AssignmentPolicyTest < PunditTestCase
    %w[
      index?
      show?
      edit?
      update?
      preview_scope?
    ].each do |method|
      test method do
        assert_permit     users(:serhat)
        assert_not_permit users(:mine)
      end
    end
  end
end
