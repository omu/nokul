# frozen_string_literal: true

module Patron
  class RolePolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    def show?
      permitted? :read
    end

    def create?
      new?
    end

    def new?
      permitted? :write
    end

    def update?
      permitted?(:write) && !record.locked?
    end

    def edit?
      update? && !record.locked?
    end

    def destroy?
      permitted?(:destroy) && !record.locked?
    end

    private

    def permitted?(*privileges)
      user.privilege? :role_management, privileges
    end
  end
end
