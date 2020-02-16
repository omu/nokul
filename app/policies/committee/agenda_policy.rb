# frozen_string_literal: true

module Committee
  class AgendaPolicy < ApplicationPolicy
    def create?
      permitted? :write
    end

    def destroy?
      permitted? :destroy
    end

    def edit?
      permitted? :write
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
      user.privilege? :agenda_management, privileges
    end
  end
end
