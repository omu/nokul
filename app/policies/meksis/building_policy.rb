# frozen_string_literal: true

module Meksis
  class BuildingPolicy < ApplicationPolicy
    def edit?
      permitted? :write
    end

    def index?
      permitted? :read
    end

    def show?
      permitted? :read
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :meksis_management, privileges
    end
  end
end
