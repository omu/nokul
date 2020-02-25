# frozen_string_literal: true

module TuitionManagement
  class TuitionPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    def units?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :tuition_management, privileges
    end
  end
end
