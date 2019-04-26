# frozen_string_literal: true

module Patron
  class PermissionPolicy < ApplicationPolicy
    def index?
      permitted?
    end

    def show?
      permitted?
    end

    private

    def permitted?
      user.permission? :permission_management
    end
  end
end
