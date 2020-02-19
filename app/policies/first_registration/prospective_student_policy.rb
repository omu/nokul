# frozen_string_literal: true

module FirstRegistration
  class ProspectiveStudentPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :destroy?

    def register?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :registration_management_for_students, privileges
    end
  end
end
