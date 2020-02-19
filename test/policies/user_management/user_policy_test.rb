# frozen_string_literal: true

require 'pundit_test_case'

module UserManagement
  class UserPolicyTest < PunditTestCase
    %w[
      destroy?
      edit?
      index?
      save_address_from_mernis?
      save_identity_from_mernis?
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
