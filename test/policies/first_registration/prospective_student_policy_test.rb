# frozen_string_literal: true

require 'pundit_test_case'

module FirstRegistration
  class ProspectiveStudentPolicyTest < PunditTestCase
    %w[
      create?
      edit?
      index?
      new?
      register?
      show?
      update?
    ].each do |method|
      test method do
        assert_permit     users(:serhat)
        assert_not_permit users(:mine)
      end
    end
  end
end
