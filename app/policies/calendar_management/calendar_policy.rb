# frozen_string_literal: true

module CalendarManagement
  class CalendarPolicy < ApplicationPolicy
    def create?
      permitted? :write
    end

    def destroy?
      permitted? :destroy
    end

    def duplicate?
      permitted? :write
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

    def show?
      permitted? :read
    end

    def units?
      permitted? :read
    end

    def update?
      permitted? :write
    end

    private

    def permitted?(*privileges)
      user.privilege? :calendar_management, privileges
    end
  end
end
