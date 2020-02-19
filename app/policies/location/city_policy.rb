# frozen_string_literal: true

module Location
  class CityPolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :index?

    private

    def permitted?(*privileges)
      user.privilege? :location_management, privileges
    end
  end
end
