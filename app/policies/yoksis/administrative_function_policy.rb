# frozen_string_literal: true

module Yoksis
  class AdministrativeFunctionPolicy < ApplicationPolicy
    def create?
      permitted? :write
    end

    def destroy?
      permitted? :destroy
    end

    def index?
      permitted? :read
    end

    def new?
      permitted? :write
    end

    def update?
      permitted? :write
    end

    protected

    def permitted?(*privileges)
      user.privilege? :yoksis_management, privileges
    end
  end
end
