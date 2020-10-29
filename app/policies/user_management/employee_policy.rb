# frozen_string_literal: true

module UserManagement
  class EmployeePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :employee_management, privileges
    end
  end
end
