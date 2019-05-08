# frozen_string_literal: true

module Patron
  class QueryStorePolicy < ApplicationPolicy
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
      permitted?
    end

    def edit?
      update?
    end

    def destroy?
      permitted?
    end

    def preview?
      permitted?
    end

    private

    def permitted?
      user.permission? :scope_query_management
    end
  end
end
