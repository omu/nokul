# frozen_string_literal: true

module Reference
  class TitlePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :reference_management, privileges
    end
  end
end
