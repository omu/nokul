# frozen_string_literal: true

module AccreditationManagement
  class AccreditationStandardPolicy < ApplicationPolicy
    include CrudPolicyMethods

    def units?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :accreditation_management, privileges
    end
  end
end
