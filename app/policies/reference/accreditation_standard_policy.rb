# frozen_string_literal: true

module Reference
  class AccreditationStandardPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :reference_management, privileges
    end
  end
end
