# frozen_string_literal: true

module Location
  class DistrictPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?, :show?

    private

    def permitted?(*privileges)
      user.privilege? :location_management, privileges
    end
  end
end
