# frozen_string_literal: true

module OutcomeManagement
  class UnitStandardPolicy < ApplicationPolicy
    include CrudPolicyMethods

    private

    def permitted?(*privileges)
      user.privilege? :outcome_management, privileges
    end
  end
end
