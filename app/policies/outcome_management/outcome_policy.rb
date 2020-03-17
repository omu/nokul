
# frozen_string_literal: true

module OutcomeManagement
  class OutcomePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?
  
    private
  
    def permitted?(*privileges)
      user.privilege? :outcome_management, privileges
    end
  end
end  
