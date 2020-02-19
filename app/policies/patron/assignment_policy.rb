# frozen_string_literal: true

module Patron
  class AssignmentPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :new?, :create?, :destroy?

    def preview_scope?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :authorization_management, privileges
    end
  end
end
