# frozen_string_literal: true

module Yoksis
  class AdministrativeFunctionPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    protected

    def permitted?(*privileges)
      user.privilege? :yoksis_management, privileges
    end
  end
end
