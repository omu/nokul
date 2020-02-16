# frozen_string_literal: true

module UserManagement
  class UserPolicy < ApplicationPolicy
    def destroy?
      permitted? :destroy
    end

    def edit?
      permitted? :write
    end

    def index?
      permitted? :read
    end

    def save_address_from_mernis?
      permitted? :report
    end

    def save_identity_from_mernis?
      permitted? :report
    end

    def show?
      permitted? :read
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
