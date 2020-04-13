# frozen_string_literal: true

module AccreditationManagement
  class LearningOutcomePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?

    private

    def permitted?(*privileges)
      user.privilege? :accreditation_management, privileges
    end
  end
end
