# frozen_string_literal: true

module TuitionManagement
  class TuitionDebtPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    def create_with_service?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :tuition_management, privileges
    end
  end
end
