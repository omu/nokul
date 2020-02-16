# frozen_string_literal: true

module Committee
  class DecisionPolicy < ApplicationPolicy
    def create?
      permitted? :write
    end

    def edit?
      permitted? :write
    end

    def new?
      permitted? :write
    end

    def show?
      permitted? :read
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :decision_management, privileges
    end
  end
end
