# frozen_string_literal: true

module Meksis
  class BuildingPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :new?, :create?, :destroy?

    private

    def permitted?(*privileges)
      user.privilege? :meksis_management, privileges
    end
  end
end
