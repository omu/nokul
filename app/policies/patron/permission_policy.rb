# frozen_string_literal: true

module Patron
  class PermissionPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    def show?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :permission_management, privileges
    end
  end
end
