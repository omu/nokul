# frozen_string_literal: true

module CalendarManagement
  class CalendarPolicy < ApplicationPolicy
    include CrudPolicyMethods

    def duplicate?
      permitted? :write
    end

    def units?
      permitted? :read
    end

    private

    def permitted?(*privileges)
      user.privilege? :calendar_management, privileges
    end
  end
end
