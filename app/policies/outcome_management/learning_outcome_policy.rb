# frozen_string_literal: true

module OutcomeManagement
  class LearningOutcomePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?

    private

    def permitted?(*privileges)
      user.privilege? :outcome_management, privileges
    end
  end
end
