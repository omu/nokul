# frozen_string_literal: true

module CalendarManagement
  class CalendarEventTypePolicy < ApplicationPolicy
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
      user.privilege? :calendar_management, privileges
    end
  end
end
