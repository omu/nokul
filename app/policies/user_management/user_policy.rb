# frozen_string_literal: true

module UserManagement
  class UserPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :create?, :new?

    def save_address_from_mernis?
      permitted? :write
    end

    def save_identity_from_mernis?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :user_management, privileges
    end
  end
end
