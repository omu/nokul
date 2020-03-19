# frozen_string_literal: true

module OutcomeManagement
  class StandardPolicy < ApplicationPolicy
    include CrudPolicyMethods

    def units?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :outcome_management, privileges
    end
  end
end
