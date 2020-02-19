# frozen_string_literal: true

module UserManagement
  class DutyPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?, :show?

    private

    def permitted?(*privileges)
      user.privilege? :employee_management, privileges
    end
  end
end
