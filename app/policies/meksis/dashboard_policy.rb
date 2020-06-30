# frozen_string_literal: true

module Meksis
  class DashboardPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :meksis_management, privileges
    end
  end
end
