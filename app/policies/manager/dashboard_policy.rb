# frozen_string_literal: true

module Manager
  class DashboardPolicy < ApplicationPolicy
    def stats?
      user.role?(:admin) || manager?
    end

    private

    def manager?
      Patron::Utils::RoleQuerier.new(user).institution_manager?
    end
  end
end
