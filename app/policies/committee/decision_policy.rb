# frozen_string_literal: true

module Committee
  class DecisionPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :destroy?, :index?

    private

    def permitted?(*privileges)
      user.privilege? :decision_management, privileges
    end
  end
end
