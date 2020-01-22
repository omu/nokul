# frozen_string_literal: true

module Patron
  class AssignmentPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    def show?
      permitted? :read
    end

    def update?
      permitted? :write
    end

    def edit?
      update?
    end

    def preview_scope?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :authorization_management, privileges
    end
  end
end
