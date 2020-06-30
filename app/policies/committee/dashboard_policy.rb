# frozen_string_literal: true

module Committee
  class DashboardPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :committee_management, privileges
    end
  end
end
