# frozen_string_literal: true

module Yoksis
  class StudentPunishmentTypePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :yoksis_management, privileges
    end
  end
end
