# frozen_string_literal: true

module Yoksis
  class DashboardPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :yoksis_management, privileges
    end
  end
end
