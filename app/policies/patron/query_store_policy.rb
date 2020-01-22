# frozen_string_literal: true

module Patron
  class QueryStorePolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    def show?
      permitted? :read
    end

    def new?
      create?
    end

    def create?
      permitted? :write
    end

    def update?
      permitted? :write
    end

    def edit?
      update?
    end

    def destroy?
      permitted? :destroy
    end

    def preview?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :scope_query_management, privileges
    end
  end
end
