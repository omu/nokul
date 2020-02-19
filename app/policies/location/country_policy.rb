# frozen_string_literal: true

module Location
  class CountryPolicy < ApplicationPolicy
    include CrudPolicyMethods

    private

    def permitted?(*privileges)
      user.privilege? :location_management, privileges
    end
  end
end
