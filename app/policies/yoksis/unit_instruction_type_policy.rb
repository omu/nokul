# frozen_string_literal: true

module Yoksis
  class UnitInstructionTypePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :yoksis_management, privileges
    end
  end
end
