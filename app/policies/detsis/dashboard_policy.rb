# frozen_string_literal: true

module Detsis
  class DashboardPolicy < ApplicationPolicy
    def index?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :detsis_management, privileges
    end
  end
end
