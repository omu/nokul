# frozen_string_literal: true

module Patron
  class RolePolicy < ApplicationPolicy
    def index?
      permitted?
    end

    def show?
      permitted?
    end

    def create?
      permitted?
    end

    def new?
      create?
    end

    def update?
      permitted? && !record.locked?
    end

    def edit?
      update? && !record.locked?
    end

    def destroy?
      permitted? && !record.locked?
    end

    private

    def permitted?
      user.permission? :role_management
    end
  end
end
