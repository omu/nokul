# frozen_string_literal: true

module FirstRegistration
  class ProspectiveEmployeePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :registration_management_for_employees, privileges
    end
  end
end
