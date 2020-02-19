# frozen_string_literal: true

module CalendarManagement
  class CalendarEventTypePolicy < ApplicationPolicy
    include CrudPolicyMethods

    undef :show?

    private

    def permitted?(*privileges)
      user.privilege? :calendar_management, privileges
    end
  end
end
