# frozen_string_literal: true

module Reference
  class EvaluationTypePolicy < ApplicationPolicy
    def create?
      permitted? :write
    end

    def destroy?
      permitted? :destroy
    end

    def index?
      permitted? :read
    end

    def new?
      permitted? :write
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :reference_management, privileges
    end
  end
end
