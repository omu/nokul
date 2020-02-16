# frozen_string_literal: true

module UserManagement
  class DisabilityPolicy < ApplicationPolicy
    def edit?
      permitted? :write
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :user_management, privileges
    end
  end
end
