# frozen_string_literal: true

module FirstRegistration
  class RegistrationDocumentPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :registration_management_for_students, privileges
    end
  end
end
