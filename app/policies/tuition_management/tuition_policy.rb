# frozen_string_literal: true

module TuitionManagement
  class TuitionPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :tuition_management, privileges
    end
  end
end
