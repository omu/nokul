# frozen_string_literal: true

module Reference
  class DashboardPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :reference_management, privileges
    end
  end
end
