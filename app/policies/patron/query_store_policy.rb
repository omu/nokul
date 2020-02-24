# frozen_string_literal: true

module Patron
  class QueryStorePolicy < ApplicationPolicy
    include CrudPolicyMethods

    def preview?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :scope_query_management, privileges
    end
  end
end
